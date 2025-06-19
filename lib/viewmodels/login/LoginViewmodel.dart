import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tacotaco_flutter/models/login/LoginModel.dart';
import 'package:tacotaco_flutter/models/StatusModel.dart';
import 'package:tacotaco_flutter/models/token/TokenModel.dart';
import 'package:tacotaco_flutter/utils/Url.dart';

class SignInViewModel extends ChangeNotifier {
  static final SignInViewModel instance = SignInViewModel._internal();

  factory SignInViewModel() {
    return instance;
  }

  SignInViewModel._internal();

  final storage = const FlutterSecureStorage();
  SignInRequest model = SignInRequest();

  Future<void> signIn(BuildContext context) async {
    if (model.email.isEmpty || model.password.isEmpty) {
      print("이메일이나 비밀번호가 비어있습니다.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(Url.url+'/auth/sign-in'), // 실제 API 주소
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final result = StatusModel<TokenModel>.fromJson(
          decoded,
              (data) => TokenModel.fromJson(data),
        );

        if (result.data != null) {
          await storage.write(key: 'accessToken', value: result.data!.accessToken);
          await storage.write(key: 'refreshToken', value: result.data!.refreshToken);

          // 성공 시 홈 화면으로 이동
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        print("로그인 실패: ${response.body}");
      }
    } catch (e) {
      print("에러 발생: $e");
    }
  }
}
