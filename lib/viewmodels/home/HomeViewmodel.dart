import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import 'package:tacotaco_flutter/models/home/LocationPoint.dart';

class HomeViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<LocationPoint> _locations = [];
  LatLng? _userLocation;

  List<LocationPoint> get locations => _locations;
  LatLng? get userLocation => _userLocation;

  HomeViewModel() {
    _initUserLocation();
    fetchLocations();
  }

  Future<void> _initUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) return;
      }

      final position = await Geolocator.getCurrentPosition();
      _userLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    } catch (e) {
      debugPrint("🚨 위치 가져오기 실패: $e");
    }
  }

  Future<void> fetchLocations() async {
    try {
      final response = await _dio.get('https://your-api.com/locations'); // 실제 주소로 교체
      final List data = response.data;
      _locations = data.map((e) => LocationPoint.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint("🚨 마커 데이터 로드 실패: $e");
    }
  }
}
