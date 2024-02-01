import 'package:flutter/material.dart';

class BeachCleanUpEvent {
  late int id;
  String location = "";
  String organizer = "";
  String picture = "";
  String address = "";
  int participants = 1;
  DateTime date;
  TimeOfDay time;
  BeachCleanUpEvent({
    required this.id,
    required this.location,
    required this.address,
    required this.picture,
    required this.organizer,
    required this.date,
    required this.time,
    required this.participants,
  });
}
