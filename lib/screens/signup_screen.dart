import 'package:flutter/material.dart';
import 'package:life_photo/service/signup_api'; // API 서비스 import

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final ApiService apiService = ApiService();

  bool isUserIdChecked = false;       // 중복 확인 버튼 눌렀는지
  bool isUserIdAvailable = false;     // 실제 사용 가능한 아이디인지

  @override
  void initState() {
    super.initState();
    userIdController.addListener(() {
      setState(() {
        isUserIdChecked = false;
        isUserIdAvailable = false;
      });
    });
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 4),
              // ✅ 중복 확인 결과 텍스트 표시
              if (isUserIdChecked)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isUserIdAvailable ? '사용 가능한 아이디입니다.' : '이미 사용 중인 아이디입니다.',
                    style: TextStyle(
                      color: isUserIdAvailable ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    final userId = userIdController.text.trim();

                    if (userId.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('아이디를 입력해주세요.')),
                      );
                      return;
                    }

                    final isAvailable = await apiService.checkDuplicateId(userId);

                    setState(() {
                      isUserIdChecked = true;
                      isUserIdAvailable = isAvailable;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isAvailable
                              ? '사용 가능한 아이디입니다.'
                              : '이미 사용 중인 아이디입니다.',
                        ),
                      ),
                    );
                  },
                  child: Text('아이디 중복 확인'),
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
                  final name = nameController.text.trim();
                  final userId = userIdController.text.trim();
                  final password = passwordController.text;

                  if (!isUserIdChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('아이디 중복 확인을 먼저 해주세요.')),
                    );
                    return;
                  }

                  if (!isUserIdAvailable) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('중복된 아이디입니다. 다른 아이디를 사용해주세요.')),
                    );
                    return;
                  }

                  if (password != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                    );
                    return;
                  }

                  bool success = await apiService.signUp(userId, password, name);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(success ? '회원가입 성공' : '회원가입 실패')),
                  );
                },
                child: Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
