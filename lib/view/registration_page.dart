import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waves/view/home_page.dart';
import 'package:waves/services/account.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String name = '';
  String email = '';
  String password = '';
  String address = '';
  bool broadcasting = false;
  int id = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountService.fetchAccount();
    id = AccountService.account['count'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/ocean/cover_6.JPG',
            opacity: const AlwaysStoppedAnimation(.5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        onChanged: (value) {
                          name = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'enter your name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'enter your email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'enter your password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value) {
                          address = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'enter your address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        // shadowColor: Colors.white,
                        // elevation: 3,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width * 1,
                          height: 55,
                          onPressed: () async{
                            try {
                              final user = await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              final data = _firestore.collection('users').doc(email).set({
                                'name': name,
                                'email': email,
                                'address': address,
                                'broadcasting': broadcasting,
                                'id':id+1,
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            'registration',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
