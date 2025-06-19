import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tacotaco_flutter/viewmodels/home/CardViewmodel.dart';

import 'HomeDrawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<Homescreen> {
  final viewModel = MypageViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                const CircleAvatar(radius: 36, backgroundImage: AssetImage('assets/myprofile.png')),
                const SizedBox(width: 16),
                Expanded(
                  child: viewModel.user == null
                      ? const Text('유저 정보를 불러오는 중...')
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('환영합니다, ${viewModel.user!.name}님',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(viewModel.user!.email ?? '', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            TextButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    'https://luisgunkim0642.notion.site/TacoTaco-1423df74cdba8096810aea333d129f9e'));
              },
              child: const Text('개인정보 처리 방침'),
            ),
            const SizedBox(height: 8),
            const Text('앱 버전: 1.0'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => viewModel.withdraw(context),
              child: const Text('회원 탈퇴'),
            )
          ],
        ),
      ),
    );
  }
}

