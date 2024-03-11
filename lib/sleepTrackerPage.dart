import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sleep Tracker",
      home: SleepTracker(),
    );
  }
}

class SleepTracker extends StatefulWidget {
  const SleepTracker({Key? key}) : super(key: key);

  @override
  _SleepTrackerState createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker> {
  late DateTime startTime;
  DateTime? endTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  void startSleepTracking() {
    setState(() {
      startTime = DateTime.now();
      endTime = null;
    });
  }

  void endSleepTracking() {
    setState(() {
      endTime = DateTime.now();
    });
  }

  String getSleepDuration() {
    if (endTime != null && startTime.isBefore(endTime!)) {
      Duration duration = endTime!.difference(startTime);
      int hours = duration.inHours;
      int minutes = (duration.inMinutes % 60);
      return '$hours hours and $minutes minutes';
    } else {
      return 'Not available';
    }
  }

  String getRecommendation() {
    if (endTime != null && startTime.isBefore(endTime!)) {
      Duration duration = endTime!.difference(startTime);
      int totalMinutes = duration.inMinutes;
      if (totalMinutes < 7 * 60) {
        return 'Based on your sleep duration, we recommend you to have a healthy breakfast and stay hydrated throughout the day.';
      } else {
        return 'Great job on getting enough sleep! Keep up the good work.';
      }
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Sleep Tracker",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(
                'https://images.unsplash.com/photo-1523859597145-32eff6e463ab?w=1280&h=720',
                width: 500,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 55),
            Container(
              child: Text(
                  "Start tracking your sleep by pressing the Start button"),
            ),
            SizedBox(height: 25),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB1DCEC),
                    minimumSize: Size(300, 50)),
                onPressed: startSleepTracking,
                child: Text(
                  "Start",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: Text("Sleep Duration: ${getSleepDuration()}"),
            ),
            SizedBox(height: 25),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB1DCEC),
                    minimumSize: Size(300, 50)),
                onPressed: endSleepTracking,
                child: Text(
                  "End",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: Text(
                getRecommendation(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
