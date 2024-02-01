import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({super.key});
  String? location;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 20,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Center(
              child: Text(
                location ?? 'There is where you are',
                style: const TextStyle(fontFamily: 'Playpen_Sans', fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
