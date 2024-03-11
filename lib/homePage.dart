import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:project/userInfoPage.dart';
import '/breathingTechnique.dart';
import '/foodPage.dart';
import '/journalPage.dart';
import '/quotesPage.dart';
import '/relaxingSoundsPage.dart';
import '/sleepTrackerPage.dart';
import '/yogaPage.dart';
import 'relaxingImages.dart';
import 'aboutUs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userEmail, required this.userPassword}) : super(key: key);
  final String userEmail;
  final String userPassword;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

  }

  GestureDetector buildImageContainer(String imageUrl, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 163,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 163,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Aloha",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.userEmail),
              accountEmail: null,
              currentAccountPicture: null, // No profile picture
              decoration: BoxDecoration(
                  color: Color(0xFFB1DCEC) // Customize the color
              ),
            ),
            ListTile(
              title: Text('Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfoPage(userEmail: widget.userEmail, userPassword: widget.userPassword)),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Pops the drawer
                Navigator.pop(context); // Pops the home page
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                // COLUMN 1
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                        child: buildImageContainer(
                          'https://images.unsplash.com/photo-1483546363825-7ebf25fb7513?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxqb3VybmFsfGVufDB8fHx8MTY5NjMwMDk0OXww&ixlib=rb-4.0.3&q=80&w=1080',
                          JournalPage(userEmail: widget.userEmail),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JournalPage(userEmail: widget.userEmail)),
                          );
                        },
                        child: Text("Journal", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 50, 0, 0),
                        child: buildImageContainer(
                          'https://images.unsplash.com/photo-1468174829941-1d60ae85c487?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8c2xlZXB8ZW58MHx8fHwxNjk2MzAxMDEwfDA&ixlib=rb-4.0.3&q=80&w=1080',
                          SleepTracker(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SleepTracker()),
                          );
                        },
                        child: Text("Sleep Tracker", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                        child: buildImageContainer(
                          'https://images.unsplash.com/photo-1559181567-c3190ca9959b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZnJ1aXRzfGVufDB8fHx8MTY5NjMwMTA5NHww&ixlib=rb-4.0.3&q=80&w=1080',
                          FoodPage(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodPage()),
                          );
                        },
                        child: Text("Food Page", style: TextStyle(color: Colors.black)),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                        child: buildImageContainer(
                          'https://static01.nyt.com/images/2017/04/11/science/physed-breathing/physed-breathing-superJumbo.jpg?quality=90&auto=webp',
                          BreathingPage(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BreathingPage()),
                          );
                        },
                        child: Text("Breathing Page", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // COLUMN 2
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 100, 0, 0),
                        child: buildImageContainer(
                          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHx5b2dhfGVufDB8fHx8MTY5NjI4ODkyMHww&ixlib=rb-4.0.3&q=80&w=1080',
                          YogaPage(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => YogaPage()),
                          );
                        },
                        child: Text("Yoga Page", style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 50, 0, 0),
                        child: buildImageContainer(
                          'https://images.unsplash.com/photo-1617251137884-f135eccf6942?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxM3x8cXVvdGVzfGVufDB8fHx8MTY5NjMwMTAyOHww&ixlib=rb-4.0.3&q=80&w=1080',
                          QuotesPage(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuotesPage()),
                          );
                        },
                        child: Text("Quotes Page", style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                        child: buildImageContainer(
                          'https://images.unsplash.com/photo-1466428996289-fb355538da1b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxyZWxheGluZyUyMHNvdW5kfGVufDB8fHx8MTY5NjMwMTc3OHww&ixlib=rb-4.0.3&q=80&w=400',
                          RelaxingSoundsPage(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RelaxingSoundsPage()),
                          );
                        },
                        child: Text("Relaxing Sounds", style: TextStyle(color: Colors.black)),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                        child: buildImageContainer(
                          'https://wallpapercave.com/wp/wp4964004.jpg',
                          ImagePage(),
                          context,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ImagePage()),
                          );
                        },
                        child: Text("Relaxing Images", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
