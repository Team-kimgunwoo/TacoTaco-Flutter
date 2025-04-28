import 'package:flutter/material.dart';
import 'package:tacotaco_flutter/widgets/button/CustomButton.dart';
import 'package:tacotaco_flutter/widgets/textfield/CustomTextField.dart';
import 'package:tacotaco_flutter/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // TODO: 로그인 로직 연결
    print('로그인 시도: $email / $password');
  }

  void goToSignUp() {
    // TODO: 회원가입 화면 이동
    print('회원가입 화면 이동');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                '로그인',
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
              const SizedBox(height: 40),
              CustomButton(
                text: '로그인',
                onPressed: login,
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: goToSignUp,
                  child: const Text(
                    '계정이 없으신가요? 회원가입',
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
    );
  }
}
