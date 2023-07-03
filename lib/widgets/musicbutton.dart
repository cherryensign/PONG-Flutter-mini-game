import 'package:flutter/material.dart';

class MusicButton extends StatelessWidget {
  const MusicButton(
      {Key? key, required this.playpauseMusic, required this.isMusicPlaying})
      : super(key: key);
  final VoidCallback playpauseMusic;
  final bool isMusicPlaying;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        isMusicPlaying ? Icons.music_note : Icons.music_off,
        color: isMusicPlaying ? Colors.blue[300] : Colors.red[300],
      ),
      label: Text(
        isMusicPlaying ? 'Music on' : 'Music off',
        style: TextStyle(
            color: isMusicPlaying ? Colors.blue[300] : Colors.red[300],
            fontSize: 20),
      ),
      onPressed: playpauseMusic,
    );
  }
}
