import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tacotaco_flutter/viewmodels/home/CardViewmodel.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatusCardViewModel>(context);

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
                // TODO: 향후 좋아요 기능
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
