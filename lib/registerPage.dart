import 'package:flutter/material.dart';
import '/main.dart';
import '/registration.dart';
import '/users.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Register Page",
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController emailRegistrationController = TextEditingController();
  final TextEditingController passwordRegistrationController = TextEditingController();
  final TextEditingController confirmPasswordRegistrationController = TextEditingController();
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
        appBar: AppBar(backgroundColor: Colors.white,
          title: Text("", style: TextStyle(color: Colors.black),),),
        body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: Text("Serenity Space", textAlign: TextAlign.left, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Color(0xFFB1DCEC)
                  ),),
                ),

                SizedBox(height: 50,),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
                  child: Text("Create an account", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),),
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextField(
                    controller: emailRegistrationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.grey[100]
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextField(
                    controller: passwordRegistrationController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.grey[100]
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextField(
                    controller: confirmPasswordRegistrationController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Confirm Password",
                        filled: true,
                        fillColor: Colors.grey[100]
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB1DCEC),
                          minimumSize: Size(350, 55)
                      ),
                      onPressed: () async{
                        String email = emailRegistrationController.text;
                        String password = passwordRegistrationController.text;
                        String confirmPassword = confirmPasswordRegistrationController.text;

                        // Create an instance of DatabaseHelper
                        DatabaseHelper dbHelper = DatabaseHelper.instance;

                        if(confirmPassword != password){
                          _showMessageinScaffold("Please make sure the passwords match", context);
                        }else {
                          // Create a User object with the obtained user ID and password
                          User user = User(email, password);

                          // Call the insert method to register the user
                          int? result = await dbHelper.insert(user);

                          if (result != null) {
                            // User registration successful
                            //_showMessageinScaffold("Registration Successful", context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );

                          } else {
                            // User registration failed
                            print('error inserting user in database');
                            _showMessageinScaffold("Failed to create account", context);
                          }
                        }
                      },
                      child: Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18),)
                  ),
                ),

                SizedBox(height: 40,),

                Container(
                    padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: Text("Already have an account?"),
                        ),

                        SizedBox(width: 2,),

                        Container(
                            child: TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => LoginPage())
                                );
                              },
                              child: Text("Sign In here", style: TextStyle(color: Colors.blue),),)
                        ),
                      ],
                    )
                )
              ],
            )
        )
    );
  }
}