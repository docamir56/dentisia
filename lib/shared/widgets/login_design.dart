import 'package:flutter/material.dart';

class LoginDesign extends StatelessWidget {
  const LoginDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Dentisia',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 30,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
