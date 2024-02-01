import 'package:flutter/material.dart';
import 'package:waves/view/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Waves());

}
class Waves extends StatelessWidget {
  const Waves({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      // initialRoute: ,
      // routes:{
      //
      // } ,
    );
  }
}