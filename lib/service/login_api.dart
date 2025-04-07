import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:life_photo/model/User.dart';

class ApiService extends ChangeNotifier{
  final String baseUrl;

  late User user;

  User get user_info => user;




  String? _jwt;
  String? get jwt => _jwt;

  void setJwt(String token) {
    _jwt = token;
    notifyListeners();
  }

  
  ApiService({this.baseUrl = 'http://localhost:8080/login'});

  final storage = const FlutterSecureStorage();

  Future<String> login(String userId, String password) async {
    final url = Uri.parse(baseUrl);

    // HTTP 요청 보내기
    final response = await http.post(
      url,
      body: json.encode({
        'userId': userId,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      // 헤더에서 JWT 추출
      final authorization = response.headers['authorization'];

      if (authorization != null && authorization.startsWith('Bearer ')) {
        final jwt = authorization.replaceFirst('Bearer ', '');
        await storage.write(key: 'jwt', value: jwt);
        user = User.fromJson(responseData);
       print(user.nickname);
       notifyListeners();
      }

      return responseData['msg']; // 예: 로그인 성공 메시지
    } else {
      return responseData['errorMsg'] ?? '로그인 실패';
    }
  }
}
