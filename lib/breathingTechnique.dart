import 'package:flutter/material.dart';
import 'dart:async';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BreathingPage(),
    );
  }
}

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> with TickerProviderStateMixin {
  int _secondsLeft = 10; // Initial time for inhaling and exhaling
  bool _isInhaling = true; // Flag to track inhaling/exhaling state
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _isInhaling ? 10 : 5),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
    _startTimer();
  }

  void _startTimer() {
    _controller.forward();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        // Switch between inhaling and exhaling states
        setState(() {
          _isInhaling = !_isInhaling;
          _secondsLeft = _isInhaling ? 10 : 5; // Adjust time for inhale/exhale
          _controller.duration = Duration(seconds: _isInhaling ? 10 : 5);
          if(_isInhaling){
            _controller.forward();
          }else{
            _controller.reverse();
          }
        });
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _controller.reset();
    setState(() {
      _secondsLeft = 10; // Reset to initial time
      _isInhaling = true; // Reset to inhaling state
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFB1DCEC),
        title: Text("Breathe", style: TextStyle(color: Colors.white),),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFFB1DCEC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _isInhaling ? 'Inhale' : 'Exhale',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20.0),

            Text(
              '$_secondsLeft seconds',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20.0),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB1DCEC)),
              onPressed: _resetTimer,
              child: Text('Start Over'),
            ),
          ],
        ),
      ),
    );
  }
}

