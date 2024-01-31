import 'package:flutter/material.dart';
import 'services/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(const Lab());

class Lab extends StatefulWidget {
  const Lab({super.key});

  @override
  State<Lab> createState() => _LabState();
}

class _LabState extends State<Lab> {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    NotificationService.initial(flutterLocalNotificationsPlugin);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
            child: const Text('notification'),
            onPressed: () async {
              await NotificationService.showNotification(
                title: 'notification title',
                body: 'notification body',
                flutterLocalNotificationsPlugin:
                    flutterLocalNotificationsPlugin,
              );
            },
          ),
        ),
      ),
    );
  }
}
