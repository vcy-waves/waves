import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waves/firebase_options.dart';
import 'package:waves/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}