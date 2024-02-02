import 'package:flutter/material.dart';
import 'model/event.dart';
import 'model/location.dart';

List<BeachCleanUpEvent> events = [
  BeachCleanUpEvent(
    organizer: "Eason",
    location: locations[0],
    date: DateTime.utc(2024, 4, 25),
    time: const TimeOfDay(hour: 15, minute: 30),
    participants: 1,
  ),
  BeachCleanUpEvent(
    organizer: "Aiby",
    location: locations[0],
    date: DateTime.utc(2024, 7, 25),
    time: const TimeOfDay(hour: 16, minute: 30),
    participants: 3,
  ),
  BeachCleanUpEvent(
    organizer: "Janice",
    location: locations[1],
    date: DateTime.utc(2024, 6, 25),
    time: const TimeOfDay(hour: 14, minute: 40),
    participants: 5,
  ),
];

List<Location> locations = [
  Location(
      name: '沙崙海灘',
      city: '新北市',
      district: '淡水區',
      fullAddress: '新北市淡水區沙崙路',
      street: '沙崙路',
      streetNumber: '',
      village: '',
      picture: 'testImage.png',
      rate: 4.7),
  Location(
      name: '老梅沙灘',
      city: '新北市',
      district: '石門區',
      fullAddress: '新北市石門區楓林路',
      street: '',
      streetNumber: '',
      village: '',
      picture: 'testImage.png',
      rate: 4.4),
  Location(
      name: '洲子灣',
      city: '新北市',
      district: '淡水區',
      fullAddress: '新北市淡水區',
      street: '',
      streetNumber: '',
      village: '',
      picture: 'testImage.png',
      rate: 4.0),
];
