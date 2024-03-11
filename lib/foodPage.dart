import 'package:flutter/material.dart';
import 'dart:convert';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FoodPage()
    );
  }
}

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<FoodItem> foods = [];

  @override
  void initState() {
    super.initState();
    loadFoods();
  }

  Future<void> loadFoods() async {
    // Load JSON data from a file (you may need to adjust the file path)
    String jsonString = await DefaultAssetBundle.of(context).loadString('assets/foods.json');

    // Parse the JSON data
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Extract the "foods" list
    List<dynamic> foodsList = jsonMap['foods'];

    // Create a list of FoodItem objects
    List<FoodItem> foodItems =
    foodsList.map((json) => FoodItem.fromJson(json)).toList();


    // Update the state
    setState(() {
      foods = foodItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFB1DCEC),
        title: Text("Foods", style: TextStyle(color: Colors.white),),),
      body: foods == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return GestureDetector(
            onTap: () => showFoodDetails(context, food),
            child: Card(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      food.imgPath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    child: Text(food.name),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showFoodDetails(BuildContext context, FoodItem food) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(food.name),
          content: Column(
            children: [
              Image.asset(
                food.imgPath,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(food.description),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class FoodItem {
  final String name;
  final String imgPath;
  final String description;

  FoodItem({
    required this.name,
    required this.imgPath,
    required this.description,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      imgPath: json['imgPath'],
      description: json['description'],
    );
  }
}
