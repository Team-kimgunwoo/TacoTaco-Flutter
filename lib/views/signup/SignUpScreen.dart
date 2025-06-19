import 'package:flutter/material.dart';
import 'package:tacotaco_flutter/theme/colors.dart';
import 'package:tacotaco_flutter/viewmodels/signup/SignupViewModel.dart';  // 경로 확인 필요
import 'package:tacotaco_flutter/widgets/button/CustomButton.dart';
import 'package:tacotaco_flutter/widgets/textfield/CustomTextField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  void signUp() async {
    final vm = SignUpViewModel.instance;

    vm.model.email = emailController.text.trim();
    vm.model.name = nameController.text.trim();
    vm.model.password1 = passwordController.text.trim();
    vm.model.password2 = confirmPasswordController.text.trim();

    setState(() => _isLoading = true);

    await vm.signUp(context, () {
      setState(() => _isLoading = false);
      // 회원가입 성공 시 로그인 화면으로 돌아가기
      Navigator.pop(context);
    });

    setState(() => _isLoading = false);
  }

  void goToLogin() {
    Navigator.pop(context);
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
                  label: '이름',
                  hintText: '이름을 입력하세요',
                  controller: nameController,
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
                _isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                  text: '회원가입',
                  onPressed: signUp,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '이미 계정이 있으신가요?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: goToLogin,
                        child: const Text(
                          '로그인',
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
      ),
    );
  }
}
