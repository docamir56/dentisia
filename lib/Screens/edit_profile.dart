// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  static const route = '/editProfile';

  const EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _jop;
  String? error;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  final TextEditingController _phoneNumController = TextEditingController();

  final List<String> jops = [
    "Choose your speciality",
    "Student",
    'Intern',
    "G.P",
    "Surgion",
    "Periodontics",
    "Pediatric",
    "Endodontics",
    "Orthodontics",
    "pathologist",
    'Fixed prosthetic',
    'Removable prosthetic',
    "radiologist"
  ];

  final _formKey = GlobalKey<FormState>();

  DateTime? birthDate;
  void _getBirthDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1990),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          birthDate = value;
        });
      } else {
        error = 'please insert your birthday';
      }
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final _auth = Provider.of<AuthBase>(context, listen: false);
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: appBar('edit your profile'),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextF(_userNameController, "Enter your full name",
                        textInputAction: TextInputAction.next,
                        labelText: 'User name',
                        hint: 'Full name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextF(_passwordController, "Enter your password",
                        labelText: 'Password',
                        hint: 'New password',
                        textInputAction: TextInputAction.next,
                        obscure: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextF(
                        _universityController, "Please enter your University",
                        labelText: 'University',
                        textInputAction: TextInputAction.next,
                        hint: 'Enter your University'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextF(
                        _phoneNumController, "Enter your phone as 11 character",
                        labelText: 'Phone number',
                        hint: 'Enter your phone',
                        textInputAction: TextInputAction.next,
                        keybord: TextInputType.phone),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropText(
                      state: _jop,
                      hint: "Choose your speciality",
                      map: jops.map((_jop) {
                        return DropdownMenuItem(value: _jop, child: Text(_jop));
                      }).toList(),
                      onchange: (val) => setState(() => _jop = val),
                      onSaved: (val) => setState(() => _jop = val),
                    ),
                  ),
                  MaterialButton(
                    onPressed: _getBirthDate,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      birthDate == null
                          ? 'Select your Birthday'
                          : birthDate.toString().substring(0, 10),
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.blue.shade900,
                        )
                      : materialButton(
                          () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                // await _auth.currentUser!.updateDisplayName(
                                //     _userNameController.text);
                                // await _auth.currentUser!
                                //     .updatePassword(_passwordController.text);
                                // await fireStore
                                //     .collection('user')
                                //     .doc(_auth.currentUser!.uid)
                                //     .update({
                                //   'userName': _userNameController.text,
                                //   'jop': _jop,
                                //   'university': _universityController.text,
                                //   'phoneNum':
                                //       int.parse(_phoneNumController.text),
                                //   'age': birthDate.toString().substring(0, 10),
                                // });
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          'Save',
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
