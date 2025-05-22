import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";

class StatusCardViewModel {
  // 전화 걸기
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('전화 연결 실패: $phoneNumber');
    }
  }

  // 문자 보내기
  Future<void> sendSMS(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('문자 전송 실패: $phoneNumber');
    }
  }
}
