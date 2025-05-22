import 'package:flutter/material.dart';
import 'package:tacotaco_flutter/viewmodels/home/CardViewmodel.dart'; // 경로는 프로젝트 구조에 맞게 수정

class Homeviewmodel extends StatelessWidget {
  const Homeviewmodel({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = StatusCardViewModel();

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("지금 건우는?", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("마트앞사람 찾는중...", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO: 첫 번째 기능은 추후 구현
              },
              icon: const Icon(Icons.thumb_up_alt_outlined),
            ),
            IconButton(
              onPressed: () {
                viewModel.makePhoneCall('01012345678');
              },
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {
                viewModel.sendSMS('01012345678');
              },
              icon: const Icon(Icons.chat_bubble_outline),
            ),
          ],
        ),
      ),
    );
  }
}
