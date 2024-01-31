import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() => runApp(Waves());

class Waves extends StatelessWidget {
  const Waves({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      // initialRoute:,
      // routes: {
      // },
      home: HomePage(),
    );
  }
}
