import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:waves/model/post.dart';

class PostService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final List<dynamic> _posts = [];
  static final List<dynamic> _images = [];

  static List<dynamic> get post => _posts;

  static List<dynamic> get image => _images;

  static Future<void> fetchPosts() async {
    await _firestore.collection('counter').doc('counter').get();
    final sourceFromDatabase = await _firestore.collection('posts').get();
    for (var post in sourceFromDatabase.docs) {
      var map = post.data();
      String? url = await _storage
          .ref()
          .child('images/${map['id']}.jpg')
          .getDownloadURL();
      print(map['id']);
      print(map['location']);
      _posts.add(Post(
        location: map['location'],
        initiator: map['initiator'],
        lastUpdate: DateTime.fromMicrosecondsSinceEpoch(map['lastUpdate']),
        id: map['id'],
        image: Image.network(url),
      ));
    }
  }

  static Future<void> postPost(
      {required String location,
      required String initiator,
      required DateTime lastUpdate,
      required XFile image}) async {
    int id = 0;
    final int lastUpdateToEpoch = lastUpdate.microsecondsSinceEpoch;
    final File file = File(image.path);
    var counter = await _firestore.collection('counter').doc('counter').get();
    var count = counter.data();
    if (count != null) {
      int postCounter = count['post_counter'];
      id = postCounter + 1;
    }
    _firestore.collection('posts').doc('$id').set({
      'id': id,
      'location': location,
      'initiator': initiator,
      'lastUpdate': lastUpdateToEpoch,
    });
    _firestore.collection('counter').doc('counter').update({
      'post_counter': id,
    });
    try {
      await _storage.ref('images/$id.jpg').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  static String lastUpdate({required Post post}) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(post.lastUpdate);

    if (duration.compareTo(const Duration(days: 1)) > 0) {
      return '${duration.inDays} days';
    } else if (duration.compareTo(const Duration(hours: 1)) > 0) {
      return '${duration.inHours} hours';
    } else if (duration.compareTo(const Duration(minutes: 1)) > 0) {
      return '${duration.inMinutes} minutes';
    } else {
      return '${duration.inSeconds} seconds';
    }
  }
}
