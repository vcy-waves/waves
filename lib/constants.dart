import 'package:flutter/material.dart';

enum NotiType { normal, immediate, fine }

const kSmallTitleTextStyle =
    TextStyle(fontFamily: 'Playpen_Sans', fontSize: 20.0);

const kLargeTitleTextStyle =
    TextStyle(fontFamily: 'Playpen_Sans', fontSize: 80.0);

final kSearchBarInputDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  hintText: '🔎請輸入沙灘名稱',
);
