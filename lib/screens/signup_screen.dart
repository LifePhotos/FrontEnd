import 'package:flutter/material.dart';
import 'package:life_photo/service/signup_api';  // API 서비스 import

class SignUpScreen extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final ApiService apiService = ApiService();  // API 서비스 인스턴스

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true, 
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: OutlineInputBorder(),
              ),
            ),

            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // 입력 값 가져오기
                final name = nameController.text;
                final userId = userIdController.text;
                final password = passwordController.text;
                

                // 비밀번호 확인
                if (password != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('비밀번호가 일치하지 않습니다.')));
                  return;
                }

                // API 호출
                bool success = await apiService.signUp(userId, password ,name);

                if (success) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('회원가입 성공')));
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('회원가입 실패')));
                }
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
