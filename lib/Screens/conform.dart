import 'package:flutter/material.dart';

class ConfirmEmail extends StatelessWidget {
  static const route = '/conform';
  static String id = 'confirm-email';

  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "An email has just been sent to you, Click the link provided to complete password reset",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      )),
    );
  }
}
