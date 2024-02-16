import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  static String id = '1';
  static final _firestore = FirebaseFirestore.instance;
  static Map<String, dynamic> _post = {};
  static Future<void> fetchPost() async {
    final source = await _firestore.collection('posts').doc(id).get();
    var data = source.data();
    if (data!.isEmpty) {
      throw Exception('No such user');
    }
    _post = data;
    print(_post['id']);
    print(_post['initiator']);
    print(_post['lastUpdate']);
    print(_post['location']);
  }
}