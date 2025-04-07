import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("두 번째 페이지"),
      ),
      body: Center(
        child: const Text("두 번째 페이지에 오신 것을 환영합니다!"),
      ),
    );
  }
}
