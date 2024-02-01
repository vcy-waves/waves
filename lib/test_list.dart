import 'package:flutter/material.dart';
import 'package:test_field/event.dart';
import 'package:test_field/location.dart';

List<BeachCleanUpEvent> events = [
  BeachCleanUpEvent(
    id: 1,
    picture: "testimage.png",
    organizer: "Eason",
    location: "Xinyi",
    address: "xinyi district",
    date: DateTime.utc(2024, 4, 25),
    time: const TimeOfDay(hour: 15, minute: 30),
    participants: 1,
  ),
  BeachCleanUpEvent(
    id: 2,
    picture: "testimage.png",
    organizer: "Aiby",
    location: "Datong",
    address: "ZongZeng district",
    date: DateTime.utc(2024, 7, 25),
    time: const TimeOfDay(hour: 16, minute: 30),
    participants: 3,
  ),
  BeachCleanUpEvent(
    id: 3,
    picture: "testimage.png",
    organizer: "Eason",
    location: "Xinyi",
    address: "ZongZeng district",
    date: DateTime.utc(2024, 6, 25),
    time: const TimeOfDay(hour: 14, minute: 40),
    participants: 5,
  ),
];

List<Location> locations = [
  Location(
    id: 1,
    picture: "testimage.png",
    address: "xinyi district",
    name: 'fu Beach',
    rate: 2.7,
  ),
  Location(
    id: 2,
    picture: "testimage.png",
    address: "Daan district",
    name: 'gwen Beach',
    rate: 2.7,
  ),
  Location(
    id: 3,
    picture: "testimage.png",
    address: "ZongZeng district",
    name: 'long Beach',
    rate: 3.3,
  ),
];

// List<Card> eventList = <Card>[];
