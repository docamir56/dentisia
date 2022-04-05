// ignore_for_file: avoid_print

import 'package:dentisia/Screens/forget.dart';
import 'package:dentisia/Screens/home.dart';
import 'package:dentisia/Screens/regist.dart';
import 'package:dentisia/service/auth.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/widgets/login_design.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  static const route = '/signin';

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final storage = const FlutterSecureStorage();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? error;
  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context);

    if (showSignIn) {
      return SafeArea(
        child: Form(
          key: _formKey,
          child: Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                const LoginDesign(),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blue.shade900,
                                ),
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextF(
                          _emailController,
                          "Enter your email",
                          hint: 'example@example.com',
                          labelText: 'Email',
                          keybord: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEdittingComplete: _emailEditingComplete,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextF(
                          _passwordController,
                          "Enter your password",
                          labelText: 'Password',
                          obscure: true,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(ForgotPassword.route),
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        error != null
                            ? Text(
                                error!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 12),
                              )
                            : const Text(''),
                        const SizedBox(
                          height: 10,
                        ),
                        materialButton(() async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            // try {
                            await Auth()
                                .login(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) async {
                              await storage.write(key: 'jwt', value: value);
                              await _prov.jwtOrEmpty();
                              Navigator.of(context)
                                  .pushReplacementNamed(Home.routeId);
                            }).catchError((e) {
                              error = e.toString();
                            }).whenComplete(() {
                              _isLoading = false;
                              setState(() {});
                            });
                            // print(token);

                            // } catch (e) {
                            //   error = e.toString();

                            //       if (Platform.isAndroid) {
                            //         setState(() {
                            //           _isLoading = false;
                            //         });
                            //         switch (e.message) {
                            //           case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                            //             error = 'User is not found';

                            //             break;
                            //           case 'The password is invalid or the user does not have a password.':
                            //             error = 'Password is wrong';

                            //             break;
                            //           case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                            //             error =
                            //                 'Network Error ,please check the connection';
                            //             break;
                            //           case 'The email address is badly formatted.':
                            //             error = 'Email is wrong';
                            //             break;
                            //           case 'com.google.firebase.FirebaseException: An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
                            //             error =
                            //                 'Failed ,please check the connection';
                            //             break;
                            //           default:
                            //             print(
                            //                 'Case ${e.message} is not yet implemented');
                            //         }
                            //       } else if (Platform.isIOS) {
                            //         switch (e.code) {
                            //           case 'Error 17011':
                            //             error = 'UserNotFound';
                            //             break;
                            //           case 'Error 17009':
                            //             error = 'PasswordNotValid';
                            //             break;
                            //           case 'Error 17020':
                            //             error = 'NetworkError';
                            //             break;
                            //           // ...
                            //           default:
                            //             print(
                            //                 'Case ${e.message} is not yet implemented');
                            //         }
                            //       }
                            // } finally {
                            //   _isLoading = false;
                            // }
                          }
                        }, 'Log In'),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            toggleView();
                          },
                          child: const TextWidget(
                              item: ' Don\'t have an account?',
                              data: ' Sign up'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      );
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
