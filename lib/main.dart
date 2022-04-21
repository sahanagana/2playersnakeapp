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
      ..strokeWidth = .5
      ..style = PaintingStyle.stroke
      ..color = primaryColor;
    canvas.drawRect(Rect.fromLTWH(x,y,10,10.0), paint);
  }
}


class _SunflowerState extends State<Sunflower> {
 

  @override
  Widget build(BuildContext context) {
    //width = MediaQuery.of(context).size.width;
    //height = MediaQuery.of(context).size.height;
    
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
            painter: SunflowerPainter(0),
                    
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
