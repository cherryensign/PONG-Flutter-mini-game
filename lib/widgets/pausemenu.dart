import 'package:flutter/material.dart';

class PauseM extends StatelessWidget {
  final resetGame;
  final exitgame;
  final continueg;
  PauseM(this.resetGame, this.exitgame, this.continueg);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Center(
        child: Text(
          "Game Paused",
          style: TextStyle(color: Colors.red[300], fontSize: 30),
        ),
      ),
      actions: [
        Column(
          children: [
            Center(
              child: TextButton(
                onPressed: continueg,
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: resetGame,
                child: const Text(
                  'Restart',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: exitgame,
                child: const Text(
                  'Exit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
