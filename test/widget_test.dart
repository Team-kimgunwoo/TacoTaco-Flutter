import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tacotaco_flutter/views/login/LoginScreen.dart';

void main() {
  testWidgets('Login screen renders', (WidgetTester tester) async {
    // 앱처럼 직접 MaterialApp을 구성해서 테스트
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    ));

    // 원하는 위젯이 보이는지 확인 (예: "로그인" 텍스트)
    expect(find.text('로그인'), findsOneWidget);
  });
}
