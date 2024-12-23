import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'report_page.dart';

class FaceDetectionScreen extends StatefulWidget {
  final CameraDescription camera;

  const FaceDetectionScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // 전면 카메라 초기화
    _controller = CameraController(widget.camera, ResolutionPreset.medium, enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
          // Fill the entire screen with the background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
      FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                // 카메라 미리보기
                Positioned(
                  top: 150, // 상단 여백 조절
                  left: 50, // 좌측 여백 조절
                  right: 50, // 우측 여백 조절
                  bottom: 200, // 하단 여백 조절
                  child: CameraPreview(_controller),
                ),

                // 가이드라인 및 텍스트 추가
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 상단 안내 텍스트
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(
                          '입을 다물고 표정이 없는 상태로\n정면을 바라보고 찍어주세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 얼굴 가이드라인
                      Expanded(
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Stack(
                              children: [
                                // 얼굴 윤곽선
                                Center(
                                  child: Container(
                                    width: 200,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                  ),
                                ),
                                // 얼굴 중앙 십자선
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 125),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: 1,
                                    height: 250,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 하단 촬영 버튼
                      Padding(
                        padding: const EdgeInsets.only(bottom: 230),
                        child: IconButton(
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;
                              final picture = await _controller.takePicture();
                              // 촬영 완료 후 처리
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('사진이 저장되었습니다: ${picture.path}')),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ReportPage()),
                              );

                            } catch (e) {
                              print('Error taking picture: $e');
                            }
                          },
                          icon: Icon(Icons.camera, size: 50, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      ],
      ),
    );
  }
}
