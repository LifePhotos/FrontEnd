import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:life_photo/screens/carmera_home.dart';
import 'package:life_photo/service/login_api.dart';
import 'package:life_photo/service/Image.dart';
import 'package:life_photo/model/Image_info.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import 'package:life_photo/screens/ImagePage_screen.dart';  

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiService>(context).user_info;
    final jwt = Provider.of<ApiService>(context).jwt;
    final ImageService? imageService =
        jwt != null ? ImageService(jwtToken: jwt) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text("안녕하세요, ${user.nickname}님!"),
        centerTitle: true,
      ),
      body: imageService == null
          ? const Center(child: Text("로그인이 필요합니다."))
          : FutureBuilder<List<UserImage>>(
              future: imageService.fetchUserImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('에러 발생: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('업로드된 사진이 없습니다.'));
                } else {
                  final images = snapshot.data!;

                  return TurnPageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final item = images[index];
                      return Scaffold(
                        
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                             Expanded(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImage(imageUrl: item.imageUrl),
          ),
        );
      },
      child: Image.network(
        item.imageUrl,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) =>
            const Text('이미지를 불러올 수 없습니다.'),
      ),
    ),
  ),
),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            TurnPageRoute(
              overleafColor: const Color.fromARGB(255, 3, 3, 3),
              transitionDuration: const Duration(milliseconds: 700),
              builder: (context) => const HomeScreen(cameras: []),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
