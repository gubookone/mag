import 'package:flutter/material.dart';
import 'input_page.dart';
import 'custom_popup.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:url_launcher/url_launcher_string.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: '**',
    javaScriptAppKey: '**',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double aspectRatio = 16 / 9;
    double imageHeight = deviceWidth / aspectRatio;

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
            Image.asset('assets/images/Lift_Check.png'),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: deviceWidth,
                  height: imageHeight + 50,
                  color: Colors.grey.withOpacity(0.5),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'assets/images/face.png',
                    width: deviceWidth,
                    height: imageHeight + 50,
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            IconButton(
              icon: Image.asset('assets/images/button_1.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputPage()),
                );
              },
            ),
            Container(
              height: 70,
            ),
            IconButton(
              icon: Image.asset('assets/images/info_lift_check.png'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyCustomDialog(
                      imageName: 'assets/images/popup_1.png', // Replace with your desired image name
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Image.asset('assets/images/info_mahlgan.png'),
              onPressed: () async {
                final url = Uri.parse('https://hyper-petalite-043.notion.site/Who-are-we-10ca9455e76080e79b7bc4799308690c'); // 열고 싶은 URL
                if (await canLaunchUrlString(
                    url.toString())) { // URL 실행 가능 여부 확인
                  await launchUrlString(url.toString()); // URL 실행
                } else {
                  throw 'Could not launch $url'; // URL 실행 실패 시 에러 발생
                }
              }
            ),
            IconButton(
              icon: Image.asset('assets/images/info_notice.png'),
              onPressed: () async {
                final url = Uri.parse('https://hyper-petalite-043.notion.site/126a9455e760800e8433f7c8a38e35f0'); // 열고 싶은 URL
                if (await canLaunchUrlString(
                  url.toString())) { // URL 실행 가능 여부 확인
                  await launchUrlString(url.toString()); // URL 실행
                } else {
                throw 'Could not launch $url'; // URL 실행 실패 시 에러 발생
              }
            }
            ),

          ],
        ),
      ),
    );
  }
}
