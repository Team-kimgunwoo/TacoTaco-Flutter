import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tacotaco_flutter/utils/Url.dart';

class CoordinateItem {
  final double latitude;
  final double longitude;
  final bool isUserLocation;

  CoordinateItem({
    required this.latitude,
    required this.longitude,
    required this.isUserLocation,
  });
}

class HomeViewModel extends ChangeNotifier {
  final List<CoordinateItem> annotationItems = [];
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String distanceText = "거리 계산중..";
  CoordinateItem? serverCoordinate;

  Future<void> updateUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final userLocation = CoordinateItem(
        latitude: position.latitude,
        longitude: position.longitude,
        isUserLocation: true,
      );
      annotationItems.add(userLocation);
      _calculateDistance(userLocation);
      print("사용자 위치 업데이트: $userLocation");
      notifyListeners();
    } catch (e) {
      print("위치 가져오기 실패: $e");
    }
  }

  void updateServerLocation(double latitude, double longitude) {
    if (!annotationItems.any((item) =>
    item.latitude == latitude && item.longitude == longitude)) {
      annotationItems.add(CoordinateItem(
        latitude: latitude,
        longitude: longitude,
        isUserLocation: false,
      ));
    }
    serverCoordinate = CoordinateItem(
      latitude: latitude,
      longitude: longitude,
      isUserLocation: false,
    );
    if (annotationItems.any((e) => e.isUserLocation)) {
      final user = annotationItems.firstWhere((e) => e.isUserLocation);
      _calculateDistance(user);
    }
    notifyListeners();
  }

  void _calculateDistance(CoordinateItem user) {
    if (serverCoordinate == null) return;

    double distance = Geolocator.distanceBetween(
      user.latitude,
      user.longitude,
      serverCoordinate!.latitude,
      serverCoordinate!.longitude,
    ) / 1000;

    distanceText = "내 위치로부터 ${distance.toStringAsFixed(1)} km";
    print("계산된 거리: $distanceText");
    notifyListeners();
  }

  Future<void> fetchServerLocation() async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) {
      print("accessToken을 찾을 수 없습니다.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${Url.url}/geo'),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json['data'];
        double lat = double.parse(data['latitude']);
        double lng = double.parse(data['longitude']);
        updateServerLocation(lat, lng);
      } else {
        print("서버 위치 요청 실패: ${response.body}");
      }
    } catch (e) {
      print("서버 위치 요청 중 오류 발생: $e");
    }
  }

  Future<void> sendFCMTokenToServer() async {
    final accessToken = await storage.read(key: 'accessToken');
    final fcmToken = await storage.read(key: 'fcmToken');

    if (accessToken == null || fcmToken == null) {
      print("토큰 정보가 없습니다.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Url.url}/fcm/token?fcmToken=$fcmToken'),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        print("FCM 토큰 전송 성공");
      } else {
        print("FCM 토큰 전송 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("FCM 토큰 전송 중 에러 발생: $e");
    }
  }

  Future<void> makeCall() async {
    final url = Uri.parse("tel:01030090642");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("전화 앱 실행 실패");
    }
  }

  Future<void> sendMessage() async {
    final url = Uri.parse("sms:01030090642");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("문자 앱 실행 실패");
    }
  }

  Future<void> sendTouchRequest() async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) {
      print("accessToken을 찾을 수 없습니다.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Url.url}/fcm'),
        headers: {"Authorization": "Bearer $accessToken"},
      );
      if (response.statusCode == 200) {
        print("터치 요청 성공");
      } else {
        print("터치 요청 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("터치 요청 에러: $e");
    }
  }

  Future<void> getEmotion() async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) {
      print("accessToken을 찾을 수 없습니다.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${Url.url}/emotion'),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print("감정 데이터: $json");
      } else {
        print("감정 요청 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("감정 요청 에러: $e");
    }
  }
}
