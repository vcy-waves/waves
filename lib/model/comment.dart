import 'package:flutter/material.dart';

class Comment {
  String commenter = "";
  String content = "";
  int rating = 0;
  DateTime postedTime;
  Comment(
      {required this.commenter,
      required this.rating,
      required this.postedTime,
      required content});
}
