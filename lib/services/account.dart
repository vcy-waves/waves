import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  static final _firebase = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static Map<String, dynamic> _account = {};

  static Map<String, dynamic> get account => _account;

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static Future<void> fetchAccount() async {
    final String? email = _fetchEmail();
    final source = await _firebase.collection('users').doc(email).get();
    final count = await _firebase.collection('users').doc('count').get();
    var data = source.data();
    var id = count.data();
    if (data!.isEmpty) {
      throw Exception('No such user');
    }
    if (id!.isEmpty) {
      throw Exception('No such user');
    }

    _account = data;
    _account.addAll(id);
    print(_account['name']);
    print(_account['address']);
    print(_account['broadcasting']);
  }

  static String? _fetchEmail() {
    String? email = _auth.currentUser!.email;
    return email;
  }
}
