import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tacotaco_flutter/utils/Url.dart';
import 'package:tacotaco_flutter/models/home/MypageModel.dart';


class MypageViewModel extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  MypageModel? user;

  Future<void> fetchUserData() async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) return;

    try {
      final response = await http.get(
        Uri.parse('${Url.url}/user/me'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user = MypageModel.fromJson(data);
        notifyListeners();
      } else {
        print('유저 정보 조회 실패: ${response.body}');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  Future<void> withdraw(BuildContext context) async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) return;

    try {
      final response = await http.delete(
        Uri.parse('${Url.url}/user/me'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        await storage.deleteAll(); // 로그아웃 처리
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        print('회원탈퇴 실패: ${response.body}');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }
}
