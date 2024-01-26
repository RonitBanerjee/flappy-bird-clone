import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  final double size;
  const Barriers({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: const Color.fromARGB(255, 0, 105, 3),
          width: 10
        )
      ),
    );
  }
}