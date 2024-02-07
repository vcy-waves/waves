import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Image photo = Image.asset('images/ocean/cover_7.JPG');
  final _firestore = FirebaseFirestore.instance;
  final _auth =FirebaseAuth.instance;
  String name = '';
  String email = '';
  String address = '';
  String personalRecord = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/ocean/cover_1.jpg',
            opacity: const AlwaysStoppedAnimation(.5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20,right: 20,),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: photo.image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                            TextField(

                            ),
                            TextField(

                            ),
                            TextField(

                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
