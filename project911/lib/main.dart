import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'main_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro to Main Example',
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: 512,
          height: 683,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/main_background.png'),
            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 202,
                        height: 202,
                        margin: const EdgeInsets.only(top: 170),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo_background.png'),
                            )
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 165,
                        margin: const EdgeInsets.only(top: 196),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/ambulance_logo.png'),
                            )
                        ),
                      ),
                      Container(
                        width: 334,
                        height: 80,
                        margin: EdgeInsets.only(top: 390),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: Colors.black, width: 3),
                          color: Colors.white,
                        ),
                        child: const Text(
                          '병상 119',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 55,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 70),
                  child: const Column(
                    children: [
                      StrokeText(
                        text: '응급의료정보제공',
                        textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffAD0000),
                        fontSize: 20,
                        ),
                        strokeColor: Colors.white,
                        strokeWidth: 2,
                      ),
                      Text(' '),
                      StrokeText(
                        text: '대한민국 응급구조대원 여러분을 응원합니다.',
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        strokeColor: Colors.white,
                        strokeWidth: 2,
                      ),
                    ],
                  )
              ),
              ElevatedButton(
                onPressed: () {
                  // 메인 화면으로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text('Go to Main Screen'),
              ),
            ],
          ),
        )
      )
    );
  }
}
