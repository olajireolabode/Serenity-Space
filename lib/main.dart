import 'package:flutter/material.dart';
import 'package:project/SplashScreen.dart';
import 'package:project/menuPage.dart';
import '/homePage.dart';
import '/registerPage.dart';
import '/registration.dart';
import 'package:awesome_notifications/awesome_notifications.dart'; // Import Awesome Notifications

void main() async{
  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: "journal_group",
            channelKey: "journal_channel",
            channelName: "journal_notif",
            channelDescription: "journal"
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: "journal_group",
            channelGroupName: "journal"
        )
      ]
  );
  bool isNotifAllowed = await AwesomeNotifications().isNotificationAllowed();
  if(!isNotifAllowed){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      home: SplashScreen(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final dbHelper = DatabaseHelper.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageinScaffold(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFFB1DCEC),
          title: Text(
            "",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                child: Text(
                  "Serenity Space",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 100, 0),
                child: Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child:
                Text("Let's get you started by filling up the form below."),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.grey[100]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey[100]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB1DCEC),
                        minimumSize: Size(350, 55)),
                    onPressed: () async {
                      // Extract text from controllers
                      final email = emailController.text;
                      final password = passwordController.text;

                      // Call dbHelper to validate user credentials
                      bool isUserRegistered = await dbHelper
                          .validateUserCredentials(email, password);

                      if (isUserRegistered) {
                        // User is registered
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage(userEmail: email, userPassword: password)));
                      } else {
                        // User is not registered
                        _showMessageinScaffold("email or password not found", context);
                      }
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        child: Text("Don't have an account?"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text(
                              "Sign Up here",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )),
                    ],
                  ))
            ],
          ),
        )
    );
  }
}
