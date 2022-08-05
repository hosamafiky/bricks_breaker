import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickWidth;
  final double brickHeight;
  final bool isBrickDead;
  const Brick({
    Key? key,
    required this.brickX,
    required this.brickY,
    required this.brickWidth,
    required this.brickHeight,
    required this.isBrickDead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isBrickDead
        ? const SizedBox.shrink()
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: Container(
              width: MediaQuery.of(context).size.width * brickWidth / 2,
              height: MediaQuery.of(context).size.height * brickHeight / 2,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          );
  }
}
