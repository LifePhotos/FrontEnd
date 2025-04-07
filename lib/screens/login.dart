import 'package:flutter/material.dart';
import 'package:life_photo/screens/main_screen.dart';
import 'package:life_photo/screens/signup_screen.dart';
import 'package:life_photo/service/login_api.dart'; // API 서비스 import
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  final jwt = await storage.read(key: 'jwt');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ApiService()..setJwt(jwt ?? ''),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    // 현재 디바이스의 화면 크기 가져오기
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final apiService = Provider.of<ApiService>(context);
    return Scaffold(
      body: Stack(
        children: [
          // 배경 GIF
          Positioned.fill(
            child: Image.asset(
              'assets/test6.gif',
              fit: BoxFit.cover,
            ),
          ),

          // 앱 제목 (가변 위치 적용)
          Align(
            alignment: Alignment(0, -0.6),
            
          ),

          // 로그인 카드 (가변 크기 적용)
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9, // 화면 가로 크기의 80% 차지
              child: Card(

                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
              '인생앨범',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Schyler",
                fontSize: screenWidth * 0.12, // 화면 크기에 맞게 글자 크기 조정
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 247, 245, 245),
              ),
            ),
           SizedBox(height: screenHeight * 0.1),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: '아이디를 입력하세요',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // 화면 크기에 맞게 조정
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // 로그인 버튼
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final email = emailController.text;
                            final password = passwordController.text;
                            String success = await apiService.login(email, password);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(success)));

                            if (success == "요청 성공") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MainPage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
       // 원하는 둥근 정도로 수정
    ),
     minimumSize: Size(double.infinity, 45),
  ),
                          child: Text('로그인'),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // 회원가입 & 비밀번호 찾기 버튼
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  },
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5), // 원하는 둥근 정도로 수정
    ),
  ),
  child: Text('회원가입'),
)),

                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // 비밀번호 찾기 기능 추가
                              },
                              style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5), // 원하는 둥근 정도로 수정
    ),
  ),
                              child: Text('비밀번호 찾기'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 카카오톡 & 구글 로그인 버튼 (반응형 적용)
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.15,
            right: screenWidth * 0.55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF9F100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(screenWidth * 0.3, 40),
              ),
              child: Text('카카오 로그인', style: TextStyle(color: Colors.black)),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.55,
            right: screenWidth * 0.15,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(screenWidth * 0.3, 40),
              ),
              child: Text('구글 로그인', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
