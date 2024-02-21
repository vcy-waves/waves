import 'package:flutter/material.dart';
import 'package:waves/services/account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String email;
  const ProfilePage({
    super.key,
    required this.email
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Image photo = Image.asset('images/ocean/cover_7.JPG');
  final _firestore = FirebaseFirestore.instance;
  bool broadcasting = true;
  String changedName = '';
  String changedEmail = '';
  String changedAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      const SizedBox(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Column(
                              children: [
                                const Text(
                                  '-Personal Info-',
                                  style: TextStyle(
                                    fontFamily: 'Playpen_Sans',
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    changedName = value;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: AccountService.account['name'],
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    changedEmail = value;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: AccountService.account['email'],
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    changedAddress = value;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: AccountService.account['address'],
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: AccountService.account['broadcasting'],
                                      hoverColor: Colors.grey,
                                      focusColor: Colors.blue,
                                      activeColor: Colors.blue,
                                      onChanged: (bool? value) {
                                        setState(() {});
                                        broadcasting = value!;
                                      },
                                    ),
                                    const Text(
                                      'allow to receive email from waves',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                IconButton(
                                  onPressed: () {
                                    final data = _firestore.collection('users').doc(widget.email);
                                    data.update({
                                      'name': changedName,
                                      'email': changedEmail,
                                      'address': changedAddress,
                                      'broadcasting': broadcasting,
                                    });
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.pencil,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return const Color(0xFF40A2E3);
                                      }
                                      return const Color(0xFFBBE2EC);
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
