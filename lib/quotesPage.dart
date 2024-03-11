import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quotes Page",
      home: QuotesPage(),
    );
  }
}

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  String quote = "Loading...";

  Future<void> fetchQuote() async {
    final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        quote = data[0]['q'];
      });
    } else {
      // Handle error
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Quotes Generator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              child: Text("Quote:", style: TextStyle(fontSize: 20),),
            ),

            SizedBox(height: 150),

            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(quote, textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
            ),

            SizedBox(height: 150),

            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFB1DCEC),
                  minimumSize: Size(300, 80),
                ),
                onPressed: () {
                  fetchQuote();
                },
                child: Text(
                  "Generate Quote",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
