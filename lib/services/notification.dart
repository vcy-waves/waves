import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waves/services/location.dart';
import 'package:geolocator/geolocator.dart';

class NotificationService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<bool> _checkIfEventIsNearBy(
      {required double destinationLatitude,
      required double destinationLongitude}) async {
    String duration = await LocatingService.calculateArrivalTime(
      destinationLatitude: destinationLatitude,
      destinationLongitude: destinationLongitude,
    );
    int time = int.parse(duration.split(' ')[0]);
    String unit = duration.split(' ')[1];
    if (!unit.contains('min')) return false;
    if (time <= 30) {
      return true;
    } else {
      return false;
    }
  }

  static void getNotificationOnFirebase(flutterLocalNotificationsPlugin) async {
    await for (var snapshot
        in _firestore.collection('notification').snapshots()) {
      for (var noti in snapshot.docs) {
        final notiModel = NotiModel(
          title: noti['title'],
          body: noti['body'],
          initiator: noti['initiator'],
          lng: noti['lon'],
          lat: noti['lat'],
          location: noti['location'],
        );
        bool sendingAllowed = await _checkIfEventIsNearBy(
          destinationLatitude: notiModel.lat,
          destinationLongitude: notiModel.lng,
        );
        String distance = await LocatingService.calculateDistance(
          destinationLatitude: notiModel.lat,
          destinationLongitude: notiModel.lng,
        );
        notiModel.distance = distance;
        if (sendingAllowed) {
          await showNotification(
            notiModel: notiModel,
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          );
        }
      }
    }
  }

  static Future<void> promoteEvent({
    required NotiType notiType,
    required String initiator,
    required String location,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    final Position position = await LocatingService.determinePosition();
    final NotiModel noti;
    if (notiType == NotiType.immediate) {
      noti = NotiModel(
        title: 'Waves',
        body: 'We need you to tidy up this ocean with us now !',
        location: location,
        lat: position.latitude,
        lng: position.longitude,
        initiator: initiator,
      );
    } else if (notiType == NotiType.normal) {
      noti = NotiModel(
        title: 'Waves',
        body: 'Come to clean up this ocean or take a rest.',
        location: location,
        lat: position.latitude,
        lng: position.longitude,
        initiator: initiator,
      );
    } else {
      noti = NotiModel(
        title: 'Waves',
        body: 'Come to visit this gorgeous ocean',
        location: location,
        lat: position.latitude,
        lng: position.longitude,
        initiator: initiator,
      );
    }
    _firestore.collection('notification').doc('channel').set({
      'title': noti.title,
      'body': noti.body,
      'initiator': noti.initiator,
      'lat': noti.lat,
      'lon': noti.lng,
      'location': noti.location,
    }).then((value) =>
        _firestore.collection('notification').doc('channel').delete());
    // });
  }

  static Future initial(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    Geolocator.requestPermission();
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
      '${notiModel.body} \n'
      '${notiModel.location} \t'
      '${notiModel.distance} away',
      notificationDetails,
    );
  }
}

class NotiModel {
  String title;
  String body;
  String initiator;
  double lat;
  double lng;
  String? distance;
  String location;

  NotiModel({
    this.distance,
    required this.location,
    required this.title,
    required this.body,
    required this.initiator,
    required this.lat,
    required this.lng,
  });
}
