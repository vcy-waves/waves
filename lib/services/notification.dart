import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/constants.dart';

class NotificationService {
  static promoteEvent({required notiType, required location, required initiator}) {
    if(notiType == NotiType.normal) {
      final NotiModel noti = NotiModel(title: 'Waves', body: 'We need you to tidy up this ocean with us now !', location: location, organizer: initiator, time: time)
    }
  }
  static Map<NotiType, NotiModel> notiTemplate = {
    NotiType.normal: NotiModel(
      title: 'Waves',
      body: 'Ocean need\'s you !',
      location: '六塊厝漁港',
      organizer: 'Chi-Yu, Li',
      time: DateTime.now(),
    ),
    NotiType.fine: NotiModel(
      title: 'Waves',
      body: 'Come to visit this gorgeous ocean ~',
      location: '六塊厝漁港',
      organizer: 'Chi-Yu, Li',
      time: DateTime.now(),
    ),
    NotiType.immediate: NotiModel(
      title: 'Waves',
      body: 'Ocean need\'s you right now ! ! !',
      location: '六塊厝漁港',
      organizer: 'Chi-Yu, Li',
      time: DateTime.now(),
    ),
  };

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
    );
  }
}

class NotiModel {
  String title;
  String body;
  String organizer;
  DateTime time;
  String location;

  NotiModel({
    required this.title,
    required this.body,
    required this.location,
    required this.organizer,
    required this.time,
  });
}
