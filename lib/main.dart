// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

const Color primaryColor = Colors.black;
const TargetPlatform platform = TargetPlatform.android;
String direction1="right";

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
    SunflowerPainter(100);
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

    final list=List<List<int>>.filled(row,List<int>.filled(col,0));
    for(int x=0;x<list.length;x++){
    for (var y = 0; y <list[x].length; y++) {
      
      drawSeed(canvas, x*10.0, y*10.0);
     
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
    canvas.drawRect(Rect.fromLTWH(x,y,100,10.0), paint);
  }
}
class SnakePainter extends CustomPainter {
  //final int seeds;
 // SnakePainter(0);

  @override
  void paint(Canvas canvas, Size size) {
    //final snake=List<int>.filled(5,1+x);
    //final snake=<int>[<int>[0,1],<int>[0,1]]; 
    //drawSeed(canvas,)
     var snake = List.generate(3, (i) => [0,i+1], growable: true);
    for(int i=0;i<snake.length;i++){
    drawSeed(canvas,snake[i][0]*1.0,snake[i][1]*1.0);
      print(snake[i][0]);
      print(snake[i][1]);
      }
    //print(dataList);
  drawSeed(canvas,100,100);  
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
    canvas.drawRect(Rect.fromLTWH(x*11,y*11,10,10), paint);
  }
}


class _SunflowerState extends State<Sunflower> {
 
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
   

    return MaterialApp(
     
     // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //platform: platform,
        brightness: Brightness.dark,
        canvasColor:Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Snake game"),
        ),
        
        body: CustomPaint(
          child: Container(
            alignment: Alignment(-0.5, -0.5),
            child: CustomPaint(painter: SnakePainter(),)
            //child: CustomPaint(painter: SunflowerPainter(),)
                    
          ),
        ),  
    )
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
