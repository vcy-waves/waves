import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waves/firebase_options.dart';
import 'package:waves/view/home_page.dart';
import 'services/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'constants.dart';
import 'services/location.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

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
    NotificationService.getNotificationOnFirebase(
        flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('notification'),
                onPressed: () async {
                  await NotificationService.promoteEvent(
                    notiType: NotiType.fine,
                    location: 'New Taipei City',
                    initiator: 'Chi-Yu',
                    flutterLocalNotificationsPlugin:
                        flutterLocalNotificationsPlugin,
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  Email mail = Email(
                    recipients: ['lichyo003@gmail.com'],
                    subject: 'wave subject',
                    cc: ['lichyo003@gmail.com', 'ttcyt1029@gmail.com'],
                    body: 'Hi there, we invite you to tidy up \${ocean}',
                    isHTML: false,
                  );
                  try {
                    await FlutterEmailSender.send(mail);
                  } catch (exception) {
                    print(exception);
                  }
                },
                child: const Text('sending email'),
              ),
              TextButton(
                onPressed: () async {
                  final location = await LocatingService.determinePosition();
                  print(location.latitude);
                  print(location.longitude);
                  // https://maps.googleapis.com/maps/api/geocode/json?latlng=25.0542428,121.4613026&language=zh-TW&key=AIzaSyDraVDjDdbDUXfQlxU6oL396YUx_noYhrs
                  Uri uri = Uri(
                    scheme: 'https',
                    host: 'maps.googleapis.com',
                    path: '/maps/api/geocode/json',
                    queryParameters: {
                      'latlng': '25.0542428,121.4613026',
                      'language': 'zh-TW',
                      'key': 'AIzaSyDraVDjDdbDUXfQlxU6oL396YUx_noYhrs'
                    },
                  );
                  final response = await http.get(uri);
                  var data = jsonDecode(response.body);
                  data = data['results'][1];
                },
                child: const Text('locate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
