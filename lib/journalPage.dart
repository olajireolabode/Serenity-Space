import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'entry.dart';
import 'view_entries_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'notifications_controller.dart';

void main() async {
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
}

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key, required this.userEmail}) : super(key: key);
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(userEmail: userEmail),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userEmail}) : super(key: key);
  final String userEmail;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  TextEditingController feelingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB1DCEC),
        title: Text(
          "Journal",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 10,),

              TextField(
                controller: feelingController,
                decoration: InputDecoration(labelText: 'How are you feeling?', border: OutlineInputBorder()),
                minLines: 3, // Adjust the size of the text field
                maxLines: 5,
              ),

              SizedBox(height: 20),

              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Describe your day', border: OutlineInputBorder()),
                minLines: 5, // Adjust the size of the text field
                maxLines: 10,
              ),

              SizedBox(height: 230),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB1DCEC),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: () {
                      AwesomeNotifications().createNotification(
                          content: NotificationContent(
                              id: 1,
                              channelKey: "journal_channel",
                              title: "Journal",
                              body: "New Journal Entry"
                          ),
                      );
                      _saveEntry();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB1DCEC),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: () {
                      _viewEntries();
                    },
                    child: Text(
                      'View',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  void _saveEntry() async {
    String feeling = feelingController.text;
    String description = descriptionController.text;
    String userEmail = widget.userEmail;

    if (feeling.isNotEmpty && description.isNotEmpty) {
      Entry entry = Entry(feeling: feeling, description: description, user_email: userEmail);
      await DatabaseHelper.instance.insertEntry(entry.toMap());
      _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Entry saved successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }

  void _viewEntries() {
    String userEmail = widget.userEmail;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewEntriesPage(userEmail: userEmail)),
    );
  }

  void _clearFields() {
    feelingController.clear();
    descriptionController.clear();
  }
}
