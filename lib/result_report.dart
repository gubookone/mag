import 'package:flutter/material.dart';
import 'report_page.dart';


class ResultReport extends StatefulWidget {
  const ResultReport({super.key});

  @override
  State<ResultReport> createState() => _ResultReport();
}

class _ResultReport extends State<ResultReport> {
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
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/last_message.png')
              ],
            ),
          ],
        ),
      ),
    );
  }
}