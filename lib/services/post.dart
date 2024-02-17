import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

  static Future<Image?> fetchPosts() async {
    await _firestore.collection('counter').doc('counter').get();
    final sourceFromDatabase = await _firestore.collection('posts').get();
    for (var rawPost in sourceFromDatabase.docs) {
      var post = rawPost.data();
      print(post['id']);
      print(post['location']);
      Uint8List? image = await _storage.ref().child('images/0.jpg').getData();
      return Image.memory(image!);
      // _posts.add(Post(
      //   location: post['location'],
      //   initiator: post['initiator'],
      //   lastUpdate: DateTime.fromMicrosecondsSinceEpoch(post['lastUpdate']),
      //   id: post['id'],
      //   image: Image.memory(image!),
      // ));
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
    var counter = await _firestore.collection('posts').doc('count').get();
    var count = counter.data();
    if (count != null) {
      id = count['count'];
      id = id + 1;
    }
    _firestore.collection('posts').doc('$id').set({
      'id': id,
      'location': location,
      'initiator': initiator,
      'lastUpdate': lastUpdateToEpoch,
    });
    _firestore.collection('posts').doc('count').update({
      'count': id,
    });
    try {
      await _storage.ref('images/$id.jpg').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
