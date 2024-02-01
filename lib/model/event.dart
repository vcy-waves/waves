import 'package:flutter/material.dart';
import 'location.dart';

class BeachCleanUpEvent {
  Location location;
  String organizer = "";
  int participants = 1;
  DateTime date;
  TimeOfDay time;
  BeachCleanUpEvent({
    required this.location,
    required this.organizer,
    required this.date,
    required this.time,
    required this.participants,
  });
}
