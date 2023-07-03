import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    // Initialize the audio player
    AudioCache player = AudioCache();
    player.loadAll(['music_file1.mp3', 'music_file2.mp3']);
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    player.play('music_file1.mp3');
    return MaterialApp(
      home: HomePage(),
    );
  }
}
