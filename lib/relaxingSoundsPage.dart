import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RelaxingSoundsPage(),
    );
  }
}

class RelaxingSoundsPage extends StatefulWidget {
  @override
  _RelaxingSoundsPageState createState() => _RelaxingSoundsPageState();
}

class _RelaxingSoundsPageState extends State<RelaxingSoundsPage> {
  late final AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playSound(String asset) {
    player.play(AssetSource(asset));
  }

  void stopSound() {
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Relaxing Sounds",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          soundButton("Rain", 'rain.mp3'),
          SizedBox(height: 30),
          soundButton("Jungle", 'jungle.mp3'),
          SizedBox(height: 30),
          soundButton("Wind", 'wind.mp3'),
          SizedBox(height: 30),
          soundButton("Thunderstorm", 'thunder.mp3'),
          SizedBox(height: 30),
          stopButton(),
        ],
      ),
    );
  }

  Widget soundButton(String label, String asset) {
    return ElevatedButton(
      onPressed: () {
        playSound(asset);
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFB1DCEC),
        onPrimary: Colors.black,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }

  Widget stopButton() {
    return ElevatedButton(
      onPressed: () {
        stopSound();
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFB1DCEC),
        onPrimary: Colors.black,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      child: Text(
        "Stop",
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}

