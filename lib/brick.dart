import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final x;
  final y;
  final brickWidth; //out of 2
  final thisisEnemy;

  MyBrick({this.x, this.y, this.brickWidth, this.thisisEnemy});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * x + brickWidth) / (2 - brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: thisisEnemy ? Colors.red[300] : Colors.blue[300],
          height: 10,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}
