import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              '환영합니다, 김주환님',
              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Kimmjuhwan07',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Image(
              image: AssetImage('assets/taco.png'), // 앱 로고 이미지 경로
              height: 80,
            ),
            const SizedBox(height: 24),
            const Divider(),
            ListTile(
              title: const Text('개인정보 처리 방침'),
              onTap: () {
                // TODO: 정책 페이지 이동
              },
            ),
            ListTile(
              title: const Text('앱 버전 1.0'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('회원 탈퇴'),
              onTap: () {
                // TODO: 탈퇴 처리
              },
            ),
          ],
        ),
      ),
    );
  }
}
