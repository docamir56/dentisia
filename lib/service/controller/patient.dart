import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/patient_model.dart';

class PatientService {
  Stream<List<Patient>> getPatientStream({required String jwt}) async* {
    yield* Stream.periodic(const Duration(seconds: 0), (_) async {
      final data = await API().get(
          url:
              'https://limitless-everglades-08570.herokuapp.com/api/v1/patients/',
          jwt: jwt);

      return data.map<Patient>((json) => Patient.fromJson(data: json)).toList();
    }).asyncMap((event) async => await event);
  }

  Future<dynamic> addPatient({
    required String jwt,
    required String patientName,
    required String medicalHistory,
    required String dentalHistory,
    required int age,
    required String complaints,
    required String location,
    required String uid,
    required int phone,
  }) async {
    Map<String, dynamic> data = await API().post(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/patients/',
        body: {
          'patientName': patientName,
          'medicalHistory': medicalHistory,
          'dentalHistory': dentalHistory,
          'age': age,
          'complaints': complaints,
          'location': location,
          'user': uid,
          'phone': phone,
          'createdAt': DateTime.now().toString(),
        },
        token: jwt);
    return data;
  }

  Future<dynamic> controllerPatient(
      {required String jwt,
      required Map<String, dynamic> body,
      required String patientId}) async {
    Map<String, dynamic> data = await API().patch(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/patients/$patientId',
        body: body,
        token: jwt);
    return data;
  }
}
