import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static List<String> datas = [];
  static List<String> getUser(){
    try{
      if (_auth.currentUser != null) {
        print(FirebaseAuth.instance.currentUser?.email);}


    }catch(e){
      throw(e);
    }

  }
}













class User{
  String name;
  String email;
  String address;
  User({
    required this.name,
    required this.email,
    required this.address,
});
}