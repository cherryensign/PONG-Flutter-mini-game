import 'package:flutter/material.dart';

class Dialogl extends StatelessWidget {
  final resetGame;
  final exitgame;
  var pointscored;
  Dialogl(this.resetGame, this.exitgame, this.pointscored);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Center(
        child: Column(children: [
          Text(
            "Game Over!",
            style: TextStyle(color: Colors.red[300], fontSize: 30),
          ),
          Text(
            "Points scored: " + pointscored.toString(),
            style: TextStyle(color: Colors.red[300], fontSize: 20),
          ),
        ]),
      ),
      actions: [
        Column(
          children: [
            Center(
              child: Container(
                child: TextButton(
                  onPressed: resetGame,
                  child: Text(
                    'Play Again',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                child: TextButton(
                  onPressed: exitgame,
                  child: Text(
                    'Exit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
