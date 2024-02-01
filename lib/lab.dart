import 'package:flutter/material.dart';
import 'services/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'constants.dart';
import 'services/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Lab());
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
                  await NotificationService.showNotification(
                    notiModel:
                        NotificationService.notiTemplate[NotiType.immediate]!,
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
                onPressed: () async{
                  final location = await LocatingService.determinePosition();
                  print(location.latitude);
                  print(location.longitude);
                  Uri uri = Uri(
                    scheme: 'https',
                    host: 'api.opencube.tw',
                    path: '/location',
                    queryParameters: {'lat': location.latitude.toString(), 'lng': location.longitude.toString(), 'key': 'AIzaSyDraVDjDdbDUXfQlxU6oL396YUx_noYhrs'}
                  );
                  final response = await http.get(uri);
                  final data = response.body;
                  print(data.toString());
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
