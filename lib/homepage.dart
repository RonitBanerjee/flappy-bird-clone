import 'dart:async';

import 'package:flappy_app/barriers.dart';
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
  bool gameEnded = false;
  static double xAxisBarrierOne = 1;
  static double yAxisBarrierBottom = 1.1;
  double yAxisBarrierTop = yAxisBarrierBottom - 2.2;
  double xAxisBarrierTwo = xAxisBarrierOne + 1.5;
  int score = 0;
  int bestScore = 0;

  void reAssign() {
    setState(() {
      yAxis = 0;
      time = 0;
      height = 0;
      initialHeight = yAxis;
      gameHasStarted = false;
      gameEnded = false;
      xAxisBarrierOne = 1;
      yAxisBarrierBottom = 1.1;
      yAxisBarrierTop = yAxisBarrierBottom - 2.2;
      xAxisBarrierTwo = xAxisBarrierOne + 1.5;
      score = 0;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = yAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      xAxisBarrierOne -= 0.05;
      xAxisBarrierTwo -= 0.05;
      time += 0.05;
      height = -4.9 * (time * time) +
          2 * time; //derived from parabola (h = - gt^2 / 2 + vt)
      setState(() {
        yAxis = initialHeight - height;
        if (yAxis > 0.385 || yAxis < -0.35) {
          timer.cancel();
          gameHasStarted = false;
          gameEnded = true;
        }
      });

      setState(() {
        if (xAxisBarrierOne < -1.1) {
          xAxisBarrierOne = 2.3;
          score++;
          if (score > bestScore) {
            bestScore = score;
          }
        } else {
          xAxisBarrierOne -= 0.05;
        }
      });

      setState(() {
        if (xAxisBarrierTwo < -1.1) {
          xAxisBarrierTwo = 2.3;
          score++;
          if (score > bestScore) {
            bestScore = score;
          }
        } else {
          xAxisBarrierTwo -= 0.05;
        }
      });

      if (yAxis > yAxisBarrierBottom || yAxis < yAxisBarrierTop) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, yAxis),
                    duration: Duration.zero,
                    color: Colors.blue,
                    child: const Bird(),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xAxisBarrierOne, yAxisBarrierBottom),
                    duration: Duration.zero,
                    child: const Barriers(
                      size: 180.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xAxisBarrierOne, yAxisBarrierTop),
                    duration: Duration.zero,
                    child: const Barriers(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xAxisBarrierTwo, yAxisBarrierBottom),
                    duration: Duration.zero,
                    child: const Barriers(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xAxisBarrierTwo, yAxisBarrierTop),
                    duration: Duration.zero,
                    child: const Barriers(
                      size: 200.0,
                    ),
                  ),
                  (!gameHasStarted || gameEnded == true)
                      ? Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                            (gameEnded == false)
                                ? 'T A P   T O   P L A Y'
                                : 'G A M E  O V E R',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox.shrink(),
                  (gameEnded == true)
                      ? GestureDetector(
                          onTap: () {
                            reAssign();
                          },
                          child: Container(
                            alignment: const Alignment(0, 0),
                            child: const Icon(Icons.restart_alt_rounded),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              height: 16,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SCORE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'BEST',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          bestScore.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
