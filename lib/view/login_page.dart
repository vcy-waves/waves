import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  static String id = 'login_page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            InputField(textInField: 'Name',),
            InputField(textInField: 'E-mail',),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  String textInField;
  InputField({
    required this.textInField,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText:textInField,
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.grey,

      ),
    );
  }
}
