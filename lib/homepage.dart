import 'dart:async';

import 'package:flappy_app/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double yAxis = 0;
  double time = 0;
  double velocity = 0;
  double height = 0;
  double initialHeight = yAxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = yAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      time += 0.05;
      height = -4.9 * (time * time) + 2 * time; //derived from parabola (h = - gt^2 / 2 + vt)
      setState(() {
        yAxis = initialHeight - height;
      });
      if (yAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, yAxis),
                duration: Duration.zero,
                color: Colors.blue,
                child: Bird(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
