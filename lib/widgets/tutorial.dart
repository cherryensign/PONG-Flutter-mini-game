import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class TutorialText extends StatelessWidget {
  const TutorialText({Key? key, required this.startgame}) : super(key: key);
  final VoidCallback startgame;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        alignment: const Alignment(0, 0),
        child: AvatarGlow(
          endRadius: 60,
          child: IconButton(
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            iconSize: 80,
            onPressed: startgame,
          ),
        ),
      ),
      Container(
        alignment: const Alignment(0, -0.4),
        child: const Text(
          "Tutorial:",
          style: TextStyle(color: Colors.pink),
        ),
      ),
      Container(
        alignment: const Alignment(0, -0.35),
        child: const Text(
          "Drag on the screen to move",
          style: TextStyle(color: Colors.pink),
        ),
      ),
      Container(
        alignment: const Alignment(0, 0.3),
        child: const Text(
          "Normal save = 1 point",
          style: TextStyle(color: Colors.pink),
        ),
      ),
      Container(
        alignment: const Alignment(0, 0.35),
        child: const Text(
          "Extra points for Risky corner saves!",
          style: TextStyle(color: Colors.pink),
        ),
      ),
    ]);
  }
}
