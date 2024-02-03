import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final _firestore = FirebaseFirestore.instance;

  static void getNotificationOnFirebase(flutterLocalNotificationsPlugin) async {
    await for (var snapshot
        in _firestore.collection('notification').snapshots()) {
      for (var noti in snapshot.docs) {
        if (noti['initiator'] == 'Chi-Yu') {
          final notiModel = NotiModel(
            title: noti['title'],
            body: noti['body'],
            location: noti['location'],
            organizer: noti['initiator'],
          );
          await showNotification(
            notiModel: notiModel,
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          );
        }
      }
    }
  }

  static promoteEvent({
    required notiType,
    required location,
    required initiator,
    required flutterLocalNotificationsPlugin,
  }) {
    final NotiModel noti;
    if (notiType == NotiType.immediate) {
      noti = NotiModel(
        title: 'Waves',
        body: 'We need you to tidy up this ocean with us now !',
        location: location,
        organizer: initiator,
      );
    } else if (notiType == NotiType.normal) {
      noti = NotiModel(
        title: 'Waves',
        body: 'Normal',
        location: location,
        organizer: initiator,
      );
    } else {
      noti = NotiModel(
        title: 'Waves',
        body: 'Come to visit this gorgeous ocean',
        location: location,
        organizer: initiator,
      );
    }
    _firestore.collection('notification').doc('channel').set({
      'title': noti.title,
      'body': noti.body,
      'initiator': noti.organizer,
      'location': noti.location,
    }).then((value) =>
        _firestore.collection('notification').doc('channel').delete());
  }

  static Future initial(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings ios = const DarwinInitializationSettings();
    final initializationSettings =
        InitializationSettings(iOS: ios, android: android);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    var id = 0,
    required NotiModel notiModel,
    var payload,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    const androidDetail = AndroidNotificationDetails(
      'waves',
      'channel_name',
      importance: Importance.max,
      playSound: true,
      priority: Priority.max,
    );
    NotificationDetails notificationDetails = const NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: androidDetail,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      notiModel.title,
      notiModel.body,
      notificationDetails,
      payload: notiModel.location,
    );
  }
}

class NotiModel {
  String title;
  String body;
  String organizer;
  String location;

  NotiModel({
    required this.title,
    required this.body,
    required this.location,
    required this.organizer,
  });
}
