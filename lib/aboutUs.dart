import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final LatLng newLocation = LatLng(45.514496, -73.674768);

  List<Marker> markers = [
    Marker(
      width: 40,
      height: 40,
      point: LatLng(45.541879, -73.730485),
      builder: (context) => Icon(Icons.location_on),
    ),
    Marker(
      width: 40,
      height: 40,
      point: LatLng(45.514496, -73.674768),
      builder: (context) => Icon(Icons.location_on),
    ),
    Marker(
      width: 40,
      height: 40,
      point: LatLng(45.510798, -73.67772),
      builder: (context) => Icon(Icons.location_on),
    ),
  ];

  String _selectedPhoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Color(0xFFB1DCEC),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  "Thank you for using Serenity Space!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\n🌟 Welcome to Serenity Space – your stress-free zone created with care by a team of college students who understand life's challenges.\n\nOur mission is to empower you to thrive with a holistic toolkit supporting your journey to tranquility.\nWe're more than developers; we're real people who've found solace, and Serenity Space is our way of sharing that support with you.\n\nBeyond an app, we're a community offering features like guided meditations and mood tracking, all designed for your well-being.\n\nLife can be tough, but you're not alone – it's okay not to be okay, and seeking help is a sign of strength.\n\nYour journey matters. Thank you for choosing Serenity Space; let's navigate this path to tranquility together.💖",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 16),
                Text(
                  "Warmly,\nThe Serenity Space Team",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 32),
                Text(
                  "Helpful Contacts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                buildHelplineTile("Talk Suicide Canada", "1 (833) 456 4566"),
                buildHelplineTile(
                    "Canada Suicide Prevention Service (CSPS)", "1 (833) 456 4566"),
                buildHelplineTile("Drug and Alcohol Helpline", "1-800-565-8603"),

                Container(
                  height: 300, // Adjust the height as needed
                  child: FlutterMap(
                    options: MapOptions(
                      center: newLocation,
                      zoom: 10,
                      maxZoom: 15,
                    ),
                    children: <Widget>[
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerClusterLayerWidget(
                        options: MarkerClusterLayerOptions(
                          maxClusterRadius: 45,
                          size: const Size(40, 40),
                          anchor: AnchorPos.align(AnchorAlign.center),
                          fitBoundsOptions: const FitBoundsOptions(
                            padding: EdgeInsets.all(50),
                            maxZoom: 15,
                          ),
                          markers: markers,
                          builder: (context, markers) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  markers.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildHelplineTile(String title, String phoneNumber) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        phoneNumber,
        style: TextStyle(fontSize: 14, color: Colors.blue),
      ),
      onTap: () => _showOptionsDialog(phoneNumber),
    );
  }

  Future<void> _showOptionsDialog(String phoneNumber) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  title: Text('Call $phoneNumber'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _makePhoneCall(phoneNumber);
                  },
                ),
                ListTile(
                  title: Text('Copy Phone Number'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _copyPhoneNumberToClipboard(phoneNumber);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      // Handle error
      print('Could not launch $phoneUrl');
    }
  }

  void _copyPhoneNumberToClipboard(String phoneNumber) {
    Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number copied to clipboard'),
      ),
    );
  }
}
