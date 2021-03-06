import 'dart:async';
import 'package:joystick/joystick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/flutter_snake.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLUTTER_SNAKE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FLUTTER_SNAKE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<GAME_EVENT>? controller;
  SnakeGame? snakeGame;

  @override
  void initState() {
    super.initState();
    controller = StreamController<GAME_EVENT>();
    controller?.stream.listen((GAME_EVENT value) {
      print(value.toString());
    });

    snakeGame = SnakeGame(
      caseWidth: 25.0,
      numberCaseHorizontally: 20,
      numberCaseVertically: 20,
      controllerEvent: controller,
      durationBetweenTicks: Duration(milliseconds: 400),
      colorBackground1: Color.fromARGB(255, 121, 192, 218),
      colorBackground2: Color.fromARGB(255, 76, 50, 205),
    );
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Snake Game"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 300,
              width: 300,
              alignment: Alignment.center,
              child: Joystick(
                size: 200,
                isDraggable: false,
                backgroundColor: Colors.black,
                opacity: 0.5,
                joystickMode: JoystickModes.all,
                onLeftPressed: () {
                  snakeGame?.nextDirection = SNAKE_MOVE.left;
                },
                onRightPressed: () {
                  snakeGame?.nextDirection = SNAKE_MOVE.right;
                },
              ),
            ),
            snakeGame ?? const Text("Not initialized"),
          ],
        ),
      ),
    );
  }
}
/*// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.
import 'package:joystick/joystick.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:simple_animations/simple_animations.dart';

const Color primaryColor = Colors.black;
const TargetPlatform platform = TargetPlatform.android;
String direction1 = "right";
GlobalKey snakex1 = GlobalKey();
//double height=0;

void main() {
  runApp(Sunflower());
}

class Sunflower extends StatefulWidget {
  @override
  final periodicTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      //print("here");
      // SunflowerPainter(100);
      // Update user about remaining time
    },
  );
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class SunflowerPainter extends CustomPainter {
  final int seeds;
  SunflowerPainter(this.seeds);

  @override
  void paint(Canvas canvas, Size size) {
    int row = 50;
    int col = 50;

    final list = List<List<int>>.filled(row, List<int>.filled(col, 0));
    for (int x = 0; x < list.length; x++) {
      for (var y = 0; y < list[x].length; y++) {
        drawSeed(canvas, x * 10.0, y * 10.0);
      }
    }
  }

  @override
  bool shouldRepaint(SunflowerPainter oldDelegate) {
    return false;
  }

  // Draw a small circle representing a seed centered at (x,y).
  void drawSeed(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = primaryColor;
    canvas.drawRect(Rect.fromLTWH(x, y, 100, 10.0), paint);
  }
}

class SnakePainter extends CustomPainter {
  //final int seeds;
  // SnakePainter(0);
  int xstart = 0;
  int ystart = 0;
  var snake = <List<int>>[];
  int direction = 2;
  SnakePainter(int x, int y) {
    xstart = x;
    ystart = y;
    for (int i = 1; i < 4; i++) {
      snake.add(<int>[0 + x, y + i + 0]);
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    //final snake=List<int>.filled(5,1+x);
    //final snake=<int>[<int>[0,1],<int>[0,1]];
    //drawSeed(canvas,)
    print(snake);
    for (int i = 0; i < snake.length; i++) {
      drawSeed(canvas, snake[i][0] * 1.0, snake[i][1] * 1.0);
    }
    //print(dataList);
    drawSeed(canvas, 100, 100);
  }

  @override
  bool shouldRepaint(SnakePainter oldDelegate) {
    return false;
  }

  // Draw a small circle representing a seed centered at (x,y).
  void drawSeed(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..strokeWidth = 1
      //..style = PaintingStyle.stroke
      ..color = Colors.green;
    canvas.drawRect(Rect.fromLTWH(x * 11, y * 11, 10, 10), paint);
  }

  void movedir(Canvas canvas, int dir) {
    direction = dir;
    final periodicTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        print("here");
        snake[0].remove;
        switch (direction) {
          case 0:
            snake
                .add(<int>[snake[snake.length][0], snake[snake.length][1] - 1]);
            break;
          case 1:
            snake
                .add(<int>[snake[snake.length][0] + 1, snake[snake.length][1]]);
            break;
          case 2:
            snake
                .add(<int>[snake[snake.length][0], snake[snake.length][1] + 1]);
            break;
          case 3:
            snake
                .add(<int>[snake[snake.length][0] - 1, snake[snake.length][1]]);
            break;
          default:
            print("you did something wrong");
        }
      },
    );
  }
}

class _SunflowerState extends State<Sunflower> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    const double size = -.5;
    int x = 0;
    int y = 0;
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //platform: platform,
        brightness: Brightness.dark,
        canvasColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Snake game"),
        ),
        body: CustomPaint(
          child: Stack(
            children: [
              Container(
                  alignment: Alignment(
                    1,
                    1,
                  ),
                  child: Joystick(
                    size: 200,
                    isDraggable: false,
                    backgroundColor: Colors.black,
                    opacity: 0.5,
                    joystickMode: JoystickModes.all,
                    onUpPressed: () {
                      CustomPaint(painter: SnakePainter(x, y));
                    },
                  )),
              Container(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    painter: SnakePainter(1, 0),
                  )
                  //child: CustomPaint(painter: SunflowerPainter(),)
                  // snakex1=
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}
*/