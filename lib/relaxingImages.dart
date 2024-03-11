import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late List<String> imageUrls;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchRandomImages();
  }

  Future<void> fetchRandomImages() async {
    final response = await http.get(Uri.parse('https://api.unsplash.com/photos/random?query=nature&count=5&client_id=nCaCmnPd8S5BT7GkcUiHRNnM6yS9YAnltKBi1SOFlPo'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        imageUrls = data.map((item) => item['urls']['regular'] as String).toList();
      });
    } else {
      throw Exception("Failed to load images");
    }
  }

  Future<void> fetchMoreImages() async {
    final response = await http.get(Uri.parse('https://api.unsplash.com/photos/random?query=relaxing&count=5&client_id=nCaCmnPd8S5BT7GkcUiHRNnM6yS9YAnltKBi1SOFlPo'));
    if (response.statusCode == 200) {
      final List<dynamic> newData = json.decode(response.body);
      setState(() {
        imageUrls.addAll(newData.map((item) => item['urls']['regular'] as String));
      });
    } else {
      throw Exception("Failed to load more images");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Relaxing Images",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return (imageUrls == null)
              ? Center(child: CircularProgressIndicator())
              : PageView.builder(
            itemCount: imageUrls.length + 1,
            controller: PageController(initialPage: currentIndex),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
              if (index == imageUrls.length - 1) {
                fetchMoreImages();
              }
            },
            itemBuilder: (context, index) {
              if (index == imageUrls.length) {
                return Center(child: CircularProgressIndicator());
              }
              return buildImageItem(imageUrls[index], orientation);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchRandomImages();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget buildImageItem(String imageUrl, Orientation orientation) {
    return GestureDetector(
      onTap: () {
        if (orientation == Orientation.portrait) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenImage(imageUrl)));
        }
      },
      child: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
