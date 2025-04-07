import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:life_photo/screens/carmera_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(HomeScreen(cameras: cameras));
}

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const HomeScreen({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(child: Text('Home Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraScreen(cameras: cameras)),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt, color: Colors.white),
      ),
      
    );
  }
}