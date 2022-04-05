import 'package:dentisia/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:dentisia/Screens/conform.dart';

class ForgotPassword extends StatefulWidget {
  static const route = '/forget';
  static String id = 'forgot-password';

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String? error;
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextF(_email, 'enter your Email',
                    keybord: TextInputType.emailAddress,
                    hint: 'Enter your email'),
                const SizedBox(height: 20),
                materialButton(() async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      // await _auth.sendPasswordResetEmail(email: _email.text);
                      Navigator.of(context).pushNamed(ConfirmEmail.route);
                    }
                  } catch (e) {
                    throw Exception('$e');
                  }
                }, 'Send Email'),
                error != null
                    ? Text(
                        error!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
