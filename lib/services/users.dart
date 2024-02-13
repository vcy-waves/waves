import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User{
  String name;
  String email;
  String address;
  User({
    required this.name,
    required this.email,
    required this.address,
  });
  // factory User.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return User(
  //     name: data?['name'],
  //     email: data?['email'],
  //     address: data?['address']
  //   );
  // }
}

class UserServices{
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  String email = '';
  static  getUser(){
    try{
      if (_auth.currentUser != null) {
        print(FirebaseAuth.instance.currentUser?.email);
        final email = FirebaseAuth.instance.currentUser?.email;
        _firestore.collection("users").doc(email).collection("name").get().then(
              (querySnapshot) {
            print("Successfully completed");
            for (var docSnapshot in querySnapshot.docs) {
              print('${docSnapshot.id} => ${docSnapshot.data()}');
            }
          },
          onError: (e) => print("Error completing: $e"),
        );
      }


    }catch(e){
      throw(e);
    }

  }
}













