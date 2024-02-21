import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Post {
  final String location;
  final DateTime lastUpdate;
  Image? image;
  final String initiator;
  bool like;
  final int id;
  int likes;
  bool isLiked;
  List<String> likers;
  String comment;

  Post({
    required this.location,
    required this.initiator,
    required this.lastUpdate,
    this.image,
    this.like = false,
    required this.id,
    required this.likes,
    required this.isLiked,
    required this.likers,
    required this.comment,
  });
}
