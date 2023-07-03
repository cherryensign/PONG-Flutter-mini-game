import 'package:flutter/material.dart';
import 'package:ponggame/widgets/tutorial.dart';
import 'dart:async';
import '../widgets/dialog.dart';
import '../widgets/pausemenu.dart';
import '../elements/brick.dart';
import '../elements/ball.dart';
import '../widgets/coverscreen.dart';
import 'mainmenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double screenWidth = 0.0;
  double playerX = -0.2;
  double brickWidth = 0.4;

  double enemyX = -0.2;

  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  bool gamenotstart = true;
  bool gameHasStarted = false;
  bool pausemenuisopen = false;

  var points = 0;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      const Duration(milliseconds: 1),
      (timer) {
        updateDirection();
        moveBall();
        moveEnemy();
        if (isPlayerDead()) {
          timer.cancel();
          _showDialog();
        }
        if (isPaused()) {
          timer.cancel();
          pausemenuopen();
        }
      },
    );
  }

  void incpoint() {
    points++;
  }

  void moveEnemy() {
    setState(() {
      if (enemyX >= -1 || enemyX <= 0.8) {
        if (ballX >= 0.8 && ballX <= 1) {
          enemyX = 0.6;
        } else if (ballX >= -1 && ballX <= -0.8) {
          enemyX = -1;
        } else {
          enemyX = ballX - 0.2;
        }
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialogl(resetGame, returnmenu, points);
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      pausemenuisopen = false;
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyX = -0.2;
      points = 0;
    });
  }

  bool isPlayerDead() {
    if (ballY >= 0.725) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.675 && playerX + brickWidth >= ballX && playerX <= ballX) {
        incpoint();
        ballYDirection = direction.UP;
      } else if (ballY <= -0.675) {
        ballYDirection = direction.DOWN;
      }

      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballY += 0.0005;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.0005;
      }

      if (ballXDirection == direction.LEFT) {
        ballX -= 0.0005;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.0005;
      }
    });
  }

  void exitmenu() {
    setState(() {
      gamenotstart = false;
    });
  }

  void returnmenu() {
    setState(() {
      resetGame();
      pausemenuisopen = false;
      gamenotstart = true;
      points = 0;
    });
  }

  bool isPaused() {
    if (pausemenuisopen) {
      return true;
    }
    return false;
  }

  void openpausemenu() {
    pausemenuisopen = true;
  }

  void pausemenuopen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PauseM(resetGame, returnmenu, continuegame);
        });
  }

  void continuegame() {
    Navigator.pop(context);
    setState(() {
      pausemenuisopen = false;
      startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return gamenotstart
        ? MenuM(exitmenu)
        : GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                playerX += details.delta.dx / screenWidth;
                if (playerX <= -1.0) {
                  playerX = -1.0;
                }
                if (playerX + brickWidth >= 1.0) {
                  playerX = 1.0 - brickWidth;
                }
              });
            },
            child: Scaffold(
              backgroundColor: Colors.grey[900],
              body: Center(
                child: Stack(children: [
                  //pointa
                  CoverScreen(
                    gameHasStarted: !gameHasStarted,
                    pointsc: points,
                  ),

                  //top brick
                  MyBrick(
                    x: enemyX,
                    y: -0.7,
                    brickWidth: brickWidth,
                    thisisEnemy: true,
                  ),

                  //bottom brick
                  MyBrick(
                    x: playerX,
                    y: 0.7,
                    brickWidth: brickWidth,
                    thisisEnemy: false,
                  ),

                  //ball
                  MyBAll(x: ballX, y: ballY),

                  !gameHasStarted
                      ? TutorialText(
                          startgame: startGame,
                        )
                      : Container(
                          alignment: const Alignment(0, 0.95),
                          child: IconButton(
                            onPressed: openpausemenu,
                            icon: const Icon(Icons.pause_circle_filled,
                                color: Colors.white),
                            iconSize: 50,
                          ),
                        ),
                ]),
              ),
            ),
          );
  }
}
