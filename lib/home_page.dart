import 'dart:async';

import 'package:bricks_breaker_game/ball.dart';
import 'package:bricks_breaker_game/brick.dart';
import 'package:bricks_breaker_game/cover_screen.dart';
import 'package:bricks_breaker_game/game_over_screen.dart';
import 'package:bricks_breaker_game/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Directions { up, down, right, left }

class _HomePageState extends State<HomePage> {
  // Game Settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  // Ball Settings
  double ballX = 0.0;
  double ballXIncrement = 0.02;
  double ballY = 0.0;
  double ballYIncrement = 0.01;
  var ballXDirection = Directions.left;
  var ballYDirection = Directions.down;

  // Brick Settings
  static double brickWidth = 0.35;
  static double brickHeight = 0.05;
  static double firstBrickX = -1 + wallGap;
  static double numberOfBricks = 5;
  static double brickGap = 0.01;
  static double firstBrickY = -0.9;
  static double wallGap =
      0.5 * (2 - numberOfBricks * brickWidth + (numberOfBricks - 1) * brickGap);

  List bricks = [
    for (int i = 0; i < 10; i++)
      for (int j = 0; j < 5; j++)
        [
          firstBrickX + j * (brickGap + brickWidth),
          firstBrickY + i * (brickGap + brickHeight),
          false
        ]
  ];

  // Player Settings
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Start the Game
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      hasGameStarted = true;
      // Update Direction
      updateDirection();
      // MoveBall
      moveBall();
      // Check if player dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      // Check for dead bricks
      checkForBrokenBrick();
    });
  }

  // Reset the Game
  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0.0;
      ballY = 0.0;
      hasGameStarted = false;
      isGameOver = false;
      ballXDirection = Directions.left;
      ballYDirection = Directions.down;
      bricks = [
        for (int i = 0; i < 10; i++)
          for (int j = 0; j < 5; j++)
            [
              firstBrickX + j * (brickGap + brickWidth),
              firstBrickY + i * (brickGap + brickHeight),
              false
            ]
      ];
    });
  }

  // Check if brick dead
  void checkForBrokenBrick() {
    for (int i = 0; i < bricks.length; i++) {
      if (ballX >= bricks[i][0] &&
          ballX <= bricks[i][0] + brickWidth &&
          ballY <= bricks[i][1] + brickHeight &&
          bricks[i][2] == false) {
        setState(() {
          bricks[i][2] = true;
        });
      }
    }
  }

  // Check if player dead
  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  // Update Direction
  void updateDirection() {
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      setState(() {
        ballYDirection = Directions.up;
      });
    } else if (ballY <= -1) {
      setState(() {
        ballYDirection = Directions.down;
      });
    } else if (ballX <= -1) {
      setState(() {
        ballXDirection = Directions.right;
      });
    } else if (ballX >= 1) {
      setState(() {
        ballXDirection = Directions.left;
      });
    }
  }

  // Move Ball
  void moveBall() {
    // Vertically
    if (ballYDirection == Directions.down) {
      setState(() {
        ballY += ballYIncrement;
      });
    } else if (ballYDirection == Directions.up) {
      setState(() {
        ballY -= ballYIncrement;
      });
    }
    // Horizontally
    if (ballXDirection == Directions.right) {
      setState(() {
        ballX += ballXIncrement;
      });
    } else if (ballXDirection == Directions.left) {
      setState(() {
        ballX -= ballXIncrement;
      });
    }
  }

  void movePlayerRight() {
    if (!(playerX + playerWidth >= 1)) {
      setState(() {
        playerX += 0.2;
      });
    }
  }

  void movePlayerLeft() {
    if (!(playerX - 0.2 < -1)) {
      setState(() {
        playerX -= 0.2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          movePlayerRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          movePlayerLeft();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          body: Stack(
            children: [
              if (isGameOver)
                // GameOver Screen
                GameOverScreen(onTap: resetGame),
              // Cover Screen if game isn't started.
              if (!hasGameStarted) const CoverScreen(),

              if (!isGameOver) ...[
                // Ball
                MyBall(ballX: ballX, ballY: ballY), // MyPlayer
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),
              ],
              for (int i = 0; i < bricks.length; i++)
                Brick(
                  brickX: bricks[i][0],
                  brickY: bricks[i][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isBrickDead: bricks[i][2],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
