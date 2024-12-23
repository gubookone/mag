import 'package:flutter/material.dart';
import 'report_page.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'face.dart';
import 'package:camera/camera.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPage();
}

class _InputPage extends State<InputPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '로그인',
              style: TextStyle(
                color: Colors.white, // 텍스트 색상을 검정색으로 설정
                fontWeight: FontWeight.w700,
                fontSize: 24, // 폰트 크기 설정
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/kakao_login_large_wide.png'),
                  onPressed: () async {

                    try {
                      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공 ${token.accessToken}');
                      try {
                        User user = await UserApi.instance.me();
                        print('사용자 정보 요청 성공'
                            '\n회원번호: ${user.id}'
                            '\n성별: ${user.kakaoAccount?.gender}'
                            '\n연령대: ${user.kakaoAccount?.ageRange}');

                        final cameras = await availableCameras();
                        final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FaceDetectionScreen(camera: frontCamera),
                          ),
                        );

                      } catch (error) {
                        print('사용자 정보 요청 실패 $error');
                      }
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}