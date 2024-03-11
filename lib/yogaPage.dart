import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YogaPose {
  final String name;
  final String image;
  final String description;

  YogaPose({
    required this.name,
    required this.image,
    required this.description,
  });
}

class YogaPage extends StatefulWidget {
  const YogaPage({Key? key}) : super(key: key);

  @override
  _YogaPageState createState() => _YogaPageState();
}

class _YogaPageState extends State<YogaPage> {
  late Future<List<YogaPose>> yogaPoses;

  @override
  void initState() {
    super.initState();
    yogaPoses = fetchData();
  }

  Future<List<YogaPose>> fetchData() async {
    final response = await http.get(Uri.parse("https://yoga-api-nzy4.onrender.com/v1/categories"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((category) => (category['poses'] as List<dynamic>).map((pose) => YogaPose(
        name: pose['english_name'],
        image: pose['url_png'],
        description: pose['pose_description'],
      )))
          .expand((poses) => poses)
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Yoga Poses",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<YogaPose>>(
        future: yogaPoses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pose = snapshot.data![index];
                return GestureDetector(
                  onTap: () => showPoseDetails(context, pose),
                  child: Card(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            pose.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          child: Text(pose.name),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Container(); // Handle other cases as needed
          }
        },
      ),
    );
  }

  void showPoseDetails(BuildContext context, YogaPose pose) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pose.name),
          content: Column(
            children: [
              Image.network(
                pose.image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(pose.description),
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
