import 'package:dio/dio.dart';
import 'package:tacotaco_flutter/models/home/LocationPoint.dart';

class LocationService {
  static final Dio _dio = Dio();
  static const String _baseUrl = 'https://your.api.com'; // 수정 필요

  static Future<List<LocationPoint>> fetchLocations() async {
    final response = await _dio.get('$_baseUrl/locations'); // 실제 엔드포인트로 교체

    final List data = response.data;
    return data.map((json) => LocationPoint.fromJson(json)).toList();
  }
}
