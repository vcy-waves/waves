import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final _firestore = FirebaseFirestore.instance;

  // static getUserDetail({required userID}) async {
  //   _firestore.collection("users").get().then(
  //     (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }

  static void getNotificationOnFirebase(flutterLocalNotificationsPlugin) async {
    await for (var snapshot
    in _firestore.collection('notificationChannel').snapshots()) {
      for (var noti in snapshot.docs) {
        if (noti['initiator'] == 'Chi-Yu') {
          final notiModel = NotiModel(
            title: noti['title'],
            body: noti['body'],
            location: noti['location'],
            organizer: noti['initiator'],
            // time: noti['time'],
          );
          _showNotification(
              notiModel: notiModel,
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
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
        // time: DateTime.now(),
      );
    } else if (notiType == NotiType.normal) {
      noti = NotiModel(
        title: 'Waves',
        body: 'Normal',
        location: location,
        organizer: initiator,
        // time: DateTime.now(),
      );
    } else {
      noti = NotiModel(
        title: 'Waves',
        body: 'Come to visit this gorgeous ocean',
        location: location,
        organizer: initiator,
        // time: DateTime.now(),
      );
    }
    _firestore.collection('notificationChannel').add(<String, dynamic>{
      'title': noti.title,
      'body': noti.body,
      'initiator': noti.organizer,
      // 'time': noti.time.toString(),
      'location': noti.location,
    });
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

  static Future<void> _showNotification({
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
  // DateTime time;
  String location;

  NotiModel({
    required this.title,
    required this.body,
    required this.location,
    required this.organizer,
    // required this.time,
  });
}