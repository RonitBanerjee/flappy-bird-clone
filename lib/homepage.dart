import 'dart:async';

import 'package:flappy_app/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double yAxis = 0;

  void jump() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        yAxis -= 0.1;
      });
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
                jump();
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
