import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waves/services/users.dart';
import 'package:waves/services/account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Image photo = Image.asset('images/ocean/cover_7.JPG');
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String name = '';
  String address = '';
  bool broadcasting = true;
  String changedName = '';
  String changedEmail = '';
  String changedAddress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountService.fetchAccount();
    email = AccountService.account['email'];
    name = AccountService.account['name'];
    address = AccountService.account['address'];
    broadcasting = AccountService.account['broadcasting'];
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: CircleAvatar(
                          backgroundImage: photo.image,
                          radius: 53,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Column(
                              children: [
                                Text(
                                  '-Personal Info-',
                                  style: TextStyle(
                                    fontFamily: 'Playpen_Sans',
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    changedName = value;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: name,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    changedEmail = value;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: email,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    changedAddress = value;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: address,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: broadcasting,
                                      hoverColor: Colors.grey,
                                      focusColor: Colors.blue,
                                      activeColor: Colors.blue,
                                      onChanged: (bool? value) {
                                        setState(() {});
                                        broadcasting = value!;
                                      },
                                    ),
                                    Text(
                                      'allow to receive email from waves',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                IconButton(
                                  onPressed: () {
                                    final data = _firestore
                                        .collection('users')
                                        .doc(email);
                                    data.update({
                                      'name': name,
                                      'email': email,
                                      'address': address,
                                      'broadcasting': broadcasting,
                                    });
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.pencil,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Color(0xFF40A2E3);
                                      }
                                      return Color(0xFFBBE2EC);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
