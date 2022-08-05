import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  const MyBall({
    Key? key,
    required this.ballX,
    required this.ballY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        width: 15.0,
        height: 15.0,
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
