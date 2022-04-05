import 'package:dentisia/service/controller/patient.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePatient extends StatelessWidget {
  static const route = '/createPatient';
  CreatePatient({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();
  final TextEditingController _dentalController = TextEditingController();
  final TextEditingController _complainController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
      child: Form(
          key: _formKey,
          child: Scaffold(
              appBar: appBar('share your patient'),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(_nameController, "Enter patient name",
                            hint: 'Patient Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(
                            _medicalController, "Enter Medical history",
                            hint: 'Medical history'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(_dentalController, "Enter dental history",
                            hint: 'Dental history'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(
                            _complainController, "Enter chief complain",
                            hint: 'Chief complain'),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextF(_descController, "Enter case description",
                      //       hint: 'Case description'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(_ageController, "Enter age",
                            hint: 'Patient age', keybord: TextInputType.number),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(_phoneController, "Enter phone",
                            hint: 'Patient phone',
                            keybord: TextInputType.number),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextF(_placeController, "Enter patient place",
                            hint: 'Patient place'),
                      ),
                      OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await PatientService().addPatient(
                                  jwt: _prov.token!,
                                  patientName: _nameController.text,
                                  medicalHistory: _medicalController.text,
                                  dentalHistory: _dentalController.text,
                                  age: int.parse(_ageController.text),
                                  complaints: _complainController.text,
                                  location: _placeController.text,
                                  uid: _prov.uid!,
                                  phone: int.parse(_phoneController.text),
                                );
                              } finally {
                                _nameController.clear();
                                _medicalController.clear();
                                _dentalController.clear();
                                _complainController.clear();
                                _descController.clear();
                                _ageController.clear();
                                _phoneController.clear();
                                _placeController.clear();

                                Navigator.pop(context);
                              }
                            }
                          },
                          child: const Text(
                            'Share',
                          )),
                    ],
                  ),
                ),
              ))),
    );
  }
}
