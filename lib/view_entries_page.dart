import 'package:flutter/material.dart';
import 'database_helper.dart';

class ViewEntriesPage extends StatelessWidget {
  ViewEntriesPage({Key? key, required this.userEmail}) : super(key: key);
  String userEmail;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "View Journal Entries",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.getAllEntries(userEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> entries = snapshot.data ?? [];
            return entries.isEmpty
                ? Center(
              child: Text(
                'No entries available.',
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      'Feeling: ${entries[index]['feeling']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Description: ${entries[index]['description']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
