import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:waves/services/notification.dart';
import 'package:waves/model/post.dart';
import 'package:waves/constants.dart';
import 'package:waves/services/account.dart';

class PostService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static List<Post> _posts = [];
  static final List<dynamic> _images = [];

  static Future<List<Post>> get post async {
    await _fetchPosts();
    _posts = sortingPost(posts: _posts);
    return _posts;
  }

  static List<dynamic> get image => _images;
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> _fetchPosts() async {
    await _firestore.collection('counter').doc('counter').get();
    final sourceFromDatabase = await _firestore.collection('posts').get();
    for (var post in sourceFromDatabase.docs) {
      var map = post.data();

      String? url = await _storage
          .ref()
          .child('images/${map['id']}.jpg')
          .getDownloadURL();

      List<dynamic> likers = map['likers'];
      List<String> likersToString = [];
      for (String liker in likers) {
        likersToString.add(liker.toString());
      }

      print('aaaaaaaaaaaaaaaaaaa');

      _posts.add(Post(
        location: map['location'],
        initiator: map['initiator'],
        lastUpdate: DateTime.fromMicrosecondsSinceEpoch(map['lastUpdate']),
        id: map['id'],
        image: Image.network(url),
        likes: map['likes'],
        likers: likersToString,
        isLiked: false,
      ));
    }
  }

  static bool fetchIsLiked(int postIndex) {
    List<String> likers = _posts[postIndex].likers;
    for (String liker in likers) {
      if (liker == AccountService.account['email']) {
        return true;
      }
    }
    return false;
  }

  static NotiType _determineNotiType({required int rating}) {
    if (rating <= 2) {
      return NotiType.immediate;
    } else if (rating <= 3) {
      return NotiType.normal;
    } else {
      return NotiType.fine;
    }
  }

  static Future<void> postPost({
    required String location,
    required String initiator,
    required DateTime lastUpdate,
    required XFile image,
    required int likes,
    required String email,
    required int rating,
  }) async {
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
      'likes': likes,
      'likers': <String>[''],
    });
    _firestore.collection('counter').doc('counter').update({
      'post_counter': id,
    });
    try {
      await _storage.ref('images/$id.jpg').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
    await NotificationService.promoteEvent(
      notiType: _determineNotiType(rating: rating),
      initiator: initiator,
      location: location,
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    );
  }

  static String lastUpdate({required Post post}) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(post.lastUpdate);

    if (duration.compareTo(const Duration(days: 2)) >= 0) {
      return '${duration.inDays} days ago';
    } else if (duration.compareTo(const Duration(days: 1)) >= 0) {
      return '${duration.inDays} day ago';
    } else if (duration.compareTo(const Duration(hours: 2)) >= 0) {
      return '${duration.inHours} hours ago';
    } else if (duration.compareTo(const Duration(hours: 1)) == 0) {
      return '${duration.inHours} hour ago';
    } else if (duration.compareTo(const Duration(minutes: 2)) >= 0) {
      return '${duration.inMinutes} minutes ago';
    } else if (duration.compareTo(const Duration(minutes: 1)) == 0) {
      return '${duration.inMinutes} minute ago';
    } else if (duration.compareTo(const Duration(seconds: 2)) >= 0) {
      return '${duration.inSeconds} seconds ago';
    } else if (duration.compareTo(const Duration(seconds: 0)) == 0) {
      return 'now !';
    } else {
      duration = post.lastUpdate.difference(now);
      if (duration.compareTo(const Duration(days: 2)) >= 0) {
        return '${duration.inDays} days later';
      } else if (duration.compareTo(const Duration(days: 1)) == 0) {
        return '${duration.inDays} day later';
      } else if (duration.compareTo(const Duration(hours: 2)) >= 0) {
        return '${duration.inHours} hours later';
      } else if (duration.compareTo(const Duration(hours: 1)) == 0) {
        return '${duration.inHours} hour later';
      } else if (duration.compareTo(const Duration(minutes: 2)) >= 0) {
        return '${duration.inMinutes} minutes later';
      } else if (duration.compareTo(const Duration(minutes: 1)) == 0) {
        return '${duration.inMinutes} minute later';
      } else {
        return '${duration.inSeconds} seconds later';
      }
    }
  }

  static Future<void> updateLike(
      {required Post post, required isLiked, required index}) async {
    //1.state的轉換
    //2.likes -1 && likers 少一筆資料
    int likes = 0;
    var datas = await _firestore.collection('posts').doc('$index').get();
    var data = datas.data();
    if (data != null) {
      likes = data['likes'];
    }
    List<String> likers = post.likers;
    String email = AccountService.account['email'];
    if (isLiked) {
      likers.add(email);
      _firestore.collection('posts').doc('${post.id}').update({
        'likers': likers,
        'likes': likes + 1,
      });
    } else {
      likers.remove(email);
      _firestore.collection('posts').doc('${post.id}').update({
        'likers': likers,
        'likes': likes - 1,
      });
    }
  }

  static List<Post> sortingPostByLikes({required List<Post> posts}) {
    for (int i = 0; i < posts.length; i++) {
      for (int j = 0; j < posts.length - 1; j++) {
        if (posts[j].likes.compareTo(posts[j + 1].likes) < 0) {
          Post post = posts[j];
          posts[j] = posts[j + 1];
          posts[j + 1] = post;
        }
      }
    }
    return posts;
  }

  static List<Post> sortingPost({required List<Post> posts}) {
    for (int i = 0; i < posts.length; i++) {
      for (int j = 0; j < posts.length - 1; j++) {
        if (posts[j].lastUpdate.compareTo(posts[j + 1].lastUpdate) < 0) {
          Post post = posts[j];
          posts[j] = posts[j + 1];
          posts[j + 1] = post;
        }
      }
    }
    for (Post post in posts) {
      print(post.lastUpdate);
    }
    return posts;
  }
}
