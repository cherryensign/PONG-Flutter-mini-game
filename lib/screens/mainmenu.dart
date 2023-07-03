import 'package:flutter/material.dart';
import 'package:ponggame/widgets/musicbutton.dart';

class MenuM extends StatelessWidget {
  final VoidCallback exitmenu;
  final VoidCallback playpauseMusic;
  final bool isMusicPlaying;

  MenuM(
    this.exitmenu,
    this.playpauseMusic,
    this.isMusicPlaying,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(children: [
        Container(
            alignment: const Alignment(0, 0),
            child: Text('PONG',
                style: TextStyle(color: Colors.red[300], fontSize: 60))),
        Container(
            alignment: const Alignment(0, 0.2),
            child: Text('by Mithilesh Ghadge',
                style: TextStyle(color: Colors.blue[300], fontSize: 20))),
        Container(
          alignment: const Alignment(0, 0.7),
          child: TextButton(
            child: Text(
              'Start Game',
              style: TextStyle(color: Colors.blue[300], fontSize: 20),
            ),
            onPressed: exitmenu,
          ),
        ),
        Container(
          alignment: const Alignment(0, 0.9),
          child: MusicButton(
              playpauseMusic: playpauseMusic, isMusicPlaying: isMusicPlaying),
        ),
      ]),
    );
  }
}
