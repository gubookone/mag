import 'package:flutter/material.dart';
import 'result_report.dart';
import 'ApiClient.dart';
import 'result_report.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> {

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
          mainAxisSize: MainAxisSize.min, // 필요한 만큼만 높이 사용
          crossAxisAlignment: CrossAxisAlignment.center, // 가로로 중앙 정렬
          children: <Widget>[
            SizedBox(height: 97), // 고정된 상단 여백
            Image.asset(
              'assets/images/face_2.png',
              width: 304,
              height: 304,
            ),
            SizedBox(height: 10), // 간격 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 19), // 여백
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Image.asset('assets/images/top_line.png'),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(5),
                        width: 150,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '왼쪽 이미지 텍스트',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Image.asset('assets/images/bottom_line.png'),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(5),
                        width: 150,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '오른쪽 이미지 텍스트',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 19), // 여백
              ],
            ),
            SizedBox(height: 10), // 간격 추가
            Image.asset('assets/images/question.png'),
            SizedBox(height: 5), // 간격 추가
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(19, 0, 19, 0),
              width: 280,
              height: 100,
              alignment: Alignment.center,
              child: Text(
                '오른쪽 이미지 텍스트 22 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),

            SizedBox(height: 10),

            IconButton(
              icon: Image.asset('assets/images/send_email.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultReport()),
                );
              },
            ),

            SizedBox(height: 5),

            IconButton(
              icon: Image.asset('assets/images/resend.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),


          ],
        ),
      ),
    );
  }

}
