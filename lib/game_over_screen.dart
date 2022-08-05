import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final Function() onTap;
  const GameOverScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: const Alignment(0.0, -0.4),
          child: const Text(
            'G  A  M  E  O  V  E  R',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: const Alignment(0.0, 0.3),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'PLAY AGAIN',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
