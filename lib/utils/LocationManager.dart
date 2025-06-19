import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager with ChangeNotifier {
  bool isAuthorized = false;
  Position? currentPosition;

  LocationManager() {
    _init();
  }

  Future<void> _init() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      isAuthorized = requested == LocationPermission.whileInUse || requested == LocationPermission.always;
    } else {
      isAuthorized = permission == LocationPermission.whileInUse || permission == LocationPermission.always;
    }

    if (isAuthorized) {
      _getLocation();
    }

    notifyListeners();
  }

  Future<void> _getLocation() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      notifyListeners();
    } catch (e) {
      print('위치 가져오기 실패: $e');
    }
  }

  double? get latitude => currentPosition?.latitude;
  double? get longitude => currentPosition?.longitude;
}
