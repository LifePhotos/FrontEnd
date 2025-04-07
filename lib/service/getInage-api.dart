import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:life_photo/model/Image_info.dart';

class ImageService {
  final String baseUrl;
  final String jwtToken;

  ImageService({
    this.baseUrl = 'http://localhost:8080/getPhoto',
    required this.jwtToken,
  });

  Future<List<UserImage>> fetchUserImages() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> data = jsonResponse['data'];
      print(data);
      return data.map((item) => UserImage.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load user images');
    }
  }
}
