// lib/views/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:tacotaco_flutter/widgets/button/CustomButton.dart';
import 'package:tacotaco_flutter/widgets/textfield/CustomTextField.dart';
import 'package:tacotaco_flutter/theme/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      // TODO: 패스워드 불일치 처리
      print('비밀번호가 일치하지 않습니다.');
      return;
    }

    // TODO: 회원가입 로직 연결
    print('회원가입 시도: $email / $password');
  }

  void goToLogin() {
    // TODO: 로그인 화면으로 이동
    print('로그인 화면 이동');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  label: '이메일',
                  hintText: '이메일을 입력하세요',
                  controller: emailController,
                ),
                CustomTextField(
                  label: '비밀번호',
                  hintText: '비밀번호를 입력하세요',
                  controller: passwordController,
                  obscureText: true,
                ),
                CustomTextField(
                  label: '비밀번호 확인',
                  hintText: '비밀번호를 다시 입력하세요',
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: '회원가입',
                  onPressed: signUp,
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: goToLogin,
                    child: const Text(
                      '이미 계정이 있으신가요? 로그인',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
