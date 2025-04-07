import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({super.key, required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  late CameraDescription _camera;
  bool isQRMode = false; // QR 코드 모드 여부

  Future<void> _initializeCamera() async {
    try {
      if (widget.cameras.isEmpty) {
        print("⚠️ 사용 가능한 카메라가 없습니다!");
        return;
      }

      _camera = widget.cameras.first;
      _controller = CameraController(_camera, ResolutionPreset.high);
      await _controller?.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("🚨 카메라 초기화 오류: $e");
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print("⚠️ 카메라가 초기화되지 않았습니다.");
      return;
    }

    try {
      final image = await _controller!.takePicture();
      print("📸 사진 저장 경로: ${image.path}");
    } catch (e) {
      print("🚨 사진 촬영 오류: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isQRMode ? 'QR 코드 모드' : '일반 촬영 모드')),
      body: Column(
        children: [
          Expanded(
            child: _controller == null || !_controller!.value.isInitialized
                ? Center(child: CircularProgressIndicator())
                : CameraPreview(_controller!),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 일반 촬영 버튼
                IconButton(
                  icon: Icon(Icons.camera, color: isQRMode ? Colors.white54 : Colors.white, size: 32),
                  onPressed: () {
                    setState(() {
                      isQRMode = false;
                    });
                  },
                ),
                // 촬영 버튼 (중앙)
                FloatingActionButton(
                  onPressed: _takePicture,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 32),
                ),
                // QR 모드 버튼
                IconButton(
                  icon: Icon(Icons.qr_code_scanner, color: isQRMode ? Colors.white : Colors.white54, size: 32),
                  onPressed: () {
                    setState(() {
                      isQRMode = true;
                    });
                  },
                ),
              ],
            ),
          ),
          // 홈 화면으로 돌아가는 버튼 추가
         
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}