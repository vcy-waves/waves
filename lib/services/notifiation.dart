import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationService {
  void askPermission() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
  }
}