import 'package:dio/dio.dart';
import 'package:tacotaco_flutter/models/home/LocationPoint.dart';
import 'package:tacotaco_flutter/utils/Url.dart';

class LocationService {
  static final Dio _dio = Dio();
  static const String _baseUrl = Url.url;

  static Future<List<LocationPoint>> fetchLocations() async {
    final response = await _dio.get('$_baseUrl/locations');

    final List data = response.data;
    return data.map((json) => LocationPoint.fromJson(json)).toList();
  }
}
