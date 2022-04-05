// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:dentisia/Screens/home.dart';
import 'package:dentisia/service/auth.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../shared/widgets/login_design.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({Key? key, this.toggleView}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final storage = const FlutterSecureStorage();
  String? _jop;

  String? error;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  final TextEditingController _phoneNumController = TextEditingController();
  final List<String> jops = [
    "Choose your speciality",
    "student",
    'intern',
    "GP",
    "surgion",
    "periodontics",
    "pediatric",
    "endodontics",
    "orthodontics",
    "pathologist",
    'prosthodontics',
    "radiologist"
  ];

  final _formKey = GlobalKey<FormState>();
  DateTime? birthDate;
  void _getBirthDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          birthDate = value;
        });
      } else {
        error = 'please insert your age';
      }
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
        child: Form(
            key: _formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const LoginDesign(),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: _buildContent(_prov))
                  ],
                ),
              ),
            )));
  }

  Widget _buildContent(Prov _prov) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextF(_userNameController, "Enter your full name",
              labelText: 'User Name',
              hint: 'Full name',
              textInputAction: TextInputAction.next,
              short: true),
          TextF(_emailController, "Enter your email",
              labelText: 'Email',
              hint: 'Create your email',
              textInputAction: TextInputAction.next,
              keybord: TextInputType.emailAddress),
          TextF(
              _passwordController, "Enter your password more than 6 character",
              labelText: 'Password',
              hint: 'create your password',
              obscure: true,
              textInputAction: TextInputAction.next,
              short: true),
          TextF(_universityController, "Please enter your University",
              labelText: 'University',
              textInputAction: TextInputAction.next,
              hint: 'Enter your University'),
          TextF(_phoneNumController, "Enter your phone as 11 character",
              labelText: 'Phone',
              textInputAction: TextInputAction.next,
              hint: 'Enter your phone',
              keybord: TextInputType.phone),
          DropText(
              state: _jop,
              hint: "Choose your speciality",
              map: jops.map((_jop) {
                return DropdownMenuItem(value: _jop, child: Text(_jop));
              }).toList(),
              onchange: (val) => setState(() => _jop = val),
              onSaved: (val) => setState(() => _jop = val)),
          MaterialButton(
            onPressed: _getBirthDate,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              birthDate == null
                  ? 'Select your Birthday'
                  : birthDate.toString().substring(0, 10),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.blue.shade900,
                ))
              : materialButton(
                  () async {
                    if (_formKey.currentState!.validate()) {
                      if (_jop == null) {
                        setState(() {
                          error = 'Please select jop';
                        });
                      } else if (birthDate == null) {
                        setState(() {
                          error = 'Please select birhtday';
                        });
                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          String token = await Auth().signup(
                            email: _emailController.text,
                            password: _passwordController.text,
                            passwordConfirmation: _passwordController.text,
                            name: _userNameController.text,
                            speciality: _jop!,
                            university: _universityController.text,
                            phone: int.parse(_phoneNumController.text),
                            age: birthDate.toString().substring(0, 10),
                          );

                          await storage.write(key: "jwt", value: token);
                          // var jwt = token.split(".");
                          // var payload = json.decode(ascii
                          //     .decode(base64.decode(base64.normalize(jwt[1]))));
                          // _prov.uid = payload["id"];
                          await _prov.jwtOrEmpty();
                          // await _prov.getUser();
                          Navigator.of(context)
                              .pushReplacementNamed(Home.routeId);
                        } catch (e) {
                          print(e.toString());
                        }
                      }
                    }
                  },
                  'Regist',
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
          TextButton(
              onPressed: () {
                widget.toggleView!();
              },
              child: const TextWidget(
                item: 'have an account?',
                data: ' Sign in',
              )),
        ],
      ),
    );
  }
}
