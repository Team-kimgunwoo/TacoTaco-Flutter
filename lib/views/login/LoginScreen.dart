import 'package:flutter/material.dart';
import 'package:tacotaco_flutter/views/home/HomeScreen.dart';
import 'package:tacotaco_flutter/views/signup/SignUpScreen.dart';
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

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen())
    );
  }

  void goToSignUp() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => const SignUpScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/taco.png'),
              const Text(
                'TACOTACO',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '아직 건우를 못보시나요?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: goToSignUp,
                      child: const Text(
                        '친구하러 가기',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
