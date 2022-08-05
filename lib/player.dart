import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final double playerX;
  final double playerWidth;
  const MyPlayer({
    Key? key,
    required this.playerX,
    required this.playerWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
      child: Container(
        width: MediaQuery.of(context).size.width * playerWidth / 2,
        height: 10.0,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
