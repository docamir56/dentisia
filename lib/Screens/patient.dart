import 'package:dentisia/Screens/create_patient.dart';
import 'package:dentisia/Screens/my_patient.dart';
import 'package:dentisia/service/controller/patient.dart';
import 'package:dentisia/service/model/patient_model.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:dentisia/shared/widgets/patient_container.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PatientPage extends StatelessWidget {
  static const route = '/patient';

  const PatientPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          appBar: appBar('Shared patient', center: false, action: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CreatePatient.route);
                },
                icon: const Icon(Icons.add_circle_outline_rounded,
                    color: Colors.blue)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MyPatient.route);
                },
                icon: const Icon(Icons.add_task_sharp, color: Colors.green))
          ]),
          body: _StreamPatientOne(
            jwt: _prov.token!,
            uid: _prov.uid!,
          )),
    );
  }
}

class _StreamPatientOne extends StatelessWidget {
  final String uid;
  final String jwt;
  const _StreamPatientOne({Key? key, required this.uid, required this.jwt})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Patient>>(
      stream: PatientService().getPatientStream(jwt: jwt),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.error.toString(),
            style: const TextStyle(color: Colors.red),
          ));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'There is no patient to share!',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
          ));
        } else if (snapshot.connectionState == ConnectionState.none) {
          return const Center(child: Text('there is no connection'));
        } else if (snapshot.connectionState == ConnectionState.active) {
          final data = snapshot.data!
              .where((element) => element.operatName == null)
              .toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return PatientContainer(
                      state: 'Take?',
                      age: data[i].age.toString(),
                      complain: data[i].complaints,
                      dental: data[i].dentalHistory,
                      medical: data[i].medicalHistory,
                      name: data[i].patientName,
                      place: data[i].location,
                      postId: data[i].patientId,
                      time: data[i]
                          .time
                          .substring(0, 16)
                          .replaceAll(RegExp(r'T'), '  -  '),
                      uid: uid,
                      username: data[i].userName,
                      phone: data[i].patientPhone.toString(),
                      userId: data[i].uid,
                      onpress: () async {
                        await PatientService().controllerPatient(
                            jwt: jwt,
                            body: {'operator': uid},
                            patientId: data[i].patientId);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('there is something is wrong'));
        }
      },
    );
  }
}
