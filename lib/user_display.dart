import 'package:flutter/material.dart';
import 'users.dart';

class UserDisplayPage extends StatefulWidget {
  final User user;

  UserDisplayPage({required this.user});

  @override
  _UserDisplayPageState createState() => _UserDisplayPageState();
}

class _UserDisplayPageState extends State<UserDisplayPage> {
  // You can add controllers for editing the email and password
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user information
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User ID: ${widget.user.id}'),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement the update functionality
                    // You may want to add validation checks before updating
                    // For simplicity, validation checks are not included here
                    // Update user information
                    widget.user.email = emailController.text;
                    widget.user.password = passwordController.text;
                    // Call the update function from the database helper
                    // DatabaseHelper.instance.update(widget.user);
                  },
                  child: Text('Update'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement the delete functionality
                    // Call the delete function from the database helper
                    // DatabaseHelper.instance.delete(widget.user.id);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
