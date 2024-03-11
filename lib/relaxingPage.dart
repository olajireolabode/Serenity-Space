import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Images Page",
      home: ImagesPage(),
    );
  }
}

class ImagesPage extends StatelessWidget {
  const ImagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Relaxing Images", style: TextStyle(color: Colors.black),),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network('https://images.squarespace-cdn.com/content/v1/5fa5ec79661ee904d2973ca0/1608218991352-VVQ4O65NM06XBN9F01ML/relaxing_photo_1.jpg?format=1500w'),
              SizedBox(height: 10,),
              Image.network('https://images.squarespace-cdn.com/content/v1/5fa5ec79661ee904d2973ca0/1608219080728-HN893TAZI776JOR15WYT/relaxing_photo_2.jpg?format=1500w',),
              SizedBox(height: 10,),
              Image.network('https://images.squarespace-cdn.com/content/v1/5fa5ec79661ee904d2973ca0/1608219121598-QHAOGI2Q4UIW418I3XK9/relaxing_photo_3.jpg?format=1500w'),
              SizedBox(height: 10,),
              Image.network('https://images.squarespace-cdn.com/content/v1/5fa5ec79661ee904d2973ca0/1608219230166-THBRJKZI3I48785NYT4H/relaxing_photo_7.jpg?format=1500w'),
              SizedBox(height: 10,),
              Image.network('https://images.squarespace-cdn.com/content/v1/5fa5ec79661ee904d2973ca0/1608219358043-R317KZC03GM7TSNER8SE/relaxing_photo_10.jpg?format=1500w'),
            ],
          ),
        )
    );
  }
}