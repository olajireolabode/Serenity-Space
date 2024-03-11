// user_info_page.dart
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({Key? key, required this.userEmail, required this.userPassword}) : super(key: key);
  final String userEmail;
  final String userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Email: $userEmail'),
            Text('Password: $userPassword'),
            // Add more user information as needed
          ],
        ),
      ),
    );
  }
}
