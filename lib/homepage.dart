import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dialog.dart';
import 'pausemenu.dart';
import 'brick.dart';
import 'ball.dart';
import 'coverscreen.dart';
import 'ControlButton.dart';
import 'mainmenu.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //player variables (bottom brick)
  double playerX = -0.2;
  double brickWidth = 0.4;

  //enemy variables (top brick)
  double enemyX = -0.2;

  //ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //game settings
  bool gamenotstart = true; //main menu on when true
  bool gameHasStarted = false; //ball movement on when true
  bool pausemenuisopen = false; //pause menu status

  //points
  var points = 0;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      //update Direction
      updateDirection();

      //move ball
      moveBall();

      //move enemy
      moveEnemy();

      //check if player lost
      if (isPlayerDead()) {
        timer.cancel();
        _showDialog();
      }

      //check if game paused
      if (isPaused()) {
        timer.cancel();
        pausemenuopen();
      }
    });
  }

//point increment
  void incpoint() {
    points++;
  }

//Enemy movement
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

//Lost Message Alert
  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialogl(resetGame, returnmenu, points);
        });
  }

//reset ball and player position
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

//checks if player lost
  bool isPlayerDead() {
    if (ballY >= 0.725) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      //update vertical
      if (ballY >= 0.675 && playerX + brickWidth >= ballX && playerX <= ballX) {
        incpoint();
        ballYDirection = direction.UP;
      } else if (ballY <= -0.675) {
        ballYDirection = direction.DOWN;
      }

      //update horizontal
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      //vertical movement
      if (ballYDirection == direction.DOWN) {
        ballY += 0.0005;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.0005;
      }

      //horizontal movement
      if (ballXDirection == direction.LEFT) {
        ballX -= 0.0005;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.0005;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX <= -1)) {
        playerX -= 0.05;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) {
        playerX += 0.05;
      }
    });
  }

//exit main menu and enters game screen
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

  //trigger to open pausemenu
  void openpausemenu() {
    pausemenuisopen = true;
  }

//opens pause menu
  void pausemenuopen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PauseM(resetGame, returnmenu, continuegame);
        });
  }

//continues the game
  void continuegame() {
    Navigator.pop(context);
    setState(() {
      pausemenuisopen = false;
      startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return gamenotstart
        ? MenuM(exitmenu)
        : RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (event) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                moveLeft();
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                moveRight();
              }
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
                      ? Stack(children: [
                          Container(
                            alignment: Alignment(0, 0),
                            child: AvatarGlow(
                              endRadius: 60,
                              child: IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                iconSize: 80,
                                onPressed: startGame,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment(0, -0.4),
                            child: Text(
                              "Tutorial:",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                          Container(
                            alignment: Alignment(0, -0.35),
                            child: Text(
                              "Tap left side of sceen to move left",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                          Container(
                            alignment: Alignment(0, -0.3),
                            child: Text(
                              "Tap right side of sceen to move right",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                          Container(
                            alignment: Alignment(0, 0.3),
                            child: Text(
                              "Normal save = 1 point",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                          Container(
                            alignment: Alignment(0, 0.35),
                            child: Text(
                              "Extra points for Risky corner saves!",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ])
                      : Stack(children: [
                          CButton(
                              leftmove: moveLeft,
                              rightmove: moveRight,
                              pauseopen: openpausemenu),
                        ]),
                ]),
              ),
            ),
          );
  }
}
