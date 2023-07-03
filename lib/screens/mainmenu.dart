import 'package:flutter/material.dart';

class MenuM extends StatelessWidget {
  final exitmenu;

  MenuM(this.exitmenu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(children: [
        Container(
            alignment: Alignment(0, 0),
            child: Text('PONG',
                style: TextStyle(color: Colors.red[300], fontSize: 60))),
        Container(
            alignment: Alignment(0, 0.2),
            child: Text('by Mithilesh Ghadge',
                style: TextStyle(color: Colors.blue[300], fontSize: 20))),
        Container(
          alignment: Alignment(0, 0.8),
          child: TextButton(
            child: Text(
              'Start Game',
              style: TextStyle(color: Colors.blue[300], fontSize: 20),
            ),
            onPressed: exitmenu,
          ),
        ),
      ]),
    );
  }
}
