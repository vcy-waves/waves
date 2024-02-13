import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  static final _firebase = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static Map<String, dynamic> account = {};

  static Future<void> fetchAccount() async {
    final String? email = _fetchEmail();
    final source = await _firebase.collection('users').doc(email).get();
    var data = source.data();
    if (data!.isEmpty) {
      throw Exception('No such user');
    }
    account = data;
    print(account['name']);
    print(account['address']);
    print(account['broadcasting']);
  }

  static String? _fetchEmail() {
    String? email = _auth.currentUser!.email;
    return email;
  }
}
