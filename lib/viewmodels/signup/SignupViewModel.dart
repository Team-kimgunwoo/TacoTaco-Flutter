import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tacotaco_flutter/utils/Url.dart';

class SignUpRequest {
  String email = '';
  String name = '';
  String password1 = '';
  String password2 = '';

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password1,
    };
  }
}

class SignUpViewModel extends ChangeNotifier {
  static final SignUpViewModel instance = SignUpViewModel._internal();

  factory SignUpViewModel() {
    return instance;
  }

  SignUpViewModel._internal();

  final storage = const FlutterSecureStorage();
  SignUpRequest model = SignUpRequest();

  bool get isAvailable {
    return model.email.isNotEmpty &&
        model.name.isNotEmpty &&
        model.password1.isNotEmpty &&
        model.password2.isNotEmpty &&
        model.password1 == model.password2;
  }

  Future<void> signUp(BuildContext context, VoidCallback onSuccess) async {
    if (!isAvailable) {
      print("입력값이 올바르지 않습니다.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${Url.url}/auth/sign-up'), // 실제 API 주소
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 201) {
        onSuccess();
      } else {
        print('회원가입 실패: ${response.body}');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }
}
