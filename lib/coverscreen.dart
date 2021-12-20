import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool gameHasStarted;
  var pointsc;

  CoverScreen({required this.gameHasStarted, this.pointsc});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      child: Text(
        gameHasStarted ? '' : "Points: " + pointsc.toString(),
        style: TextStyle(color: Colors.grey, fontSize: 40),
      ),
    );
  }
}
