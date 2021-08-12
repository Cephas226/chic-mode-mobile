import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyHomexPage extends StatefulWidget {
  MyHomexPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomexPageState createState() => _MyHomexPageState();
}

class _MyHomexPageState extends State<MyHomexPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Notification> notifications = [];
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Notification(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: Colors.red,
            ),
          );
        });
      },
      onLaunch: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Notification(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: Colors.green,
            ),
          );
        });
      },
      onResume: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Notification(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: Colors.blue,
            ),
          );
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: notifications.map(buildNotification).toList(),
      ),
    );
  }

  Widget buildNotification(Notification notification) {
    return ListTile(
      title: Text(
        notification.title,
        style: TextStyle(
          color: notification.color,
        ),
      ),
      subtitle: Text(notification.body),
    );
  }
}

class Notification {
  final String title;
  final String body;
  final Color color;
  const Notification(
      {@required this.title, @required this.body, @required this.color});
}