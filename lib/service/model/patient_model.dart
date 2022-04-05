class Patient {
  String patientName;
  String medicalHistory;
  String dentalHistory;
  int age;
  String complaints;
  List<dynamic> xRay;
  String location;
  bool taken;
  String uid;
  String userName;
  String? operatName;
  List<dynamic> mentions;
  String time;
  String patientId;
  int patientPhone;

  Patient(
      {required this.patientName,
      required this.medicalHistory,
      required this.dentalHistory,
      required this.patientId,
      required this.age,
      required this.patientPhone,
      required this.complaints,
      required this.location,
      required this.operatName,
      required this.taken,
      required this.mentions,
      required this.userName,
      required this.xRay,
      required this.time,
      required this.uid});
  factory Patient.fromJson({required Map<String, dynamic> data}) {
    return Patient(
        patientName: data['patientName'],
        medicalHistory: data['medicalHistory'],
        age: data['age'],
        dentalHistory: data['dentalHistory'],
        uid: data['user'][0]['_id'],
        taken: data['taken'],
        complaints: data['complaints'],
        location: data['location'],
        mentions: data['mentions'],
        operatName: data['operator'],
        userName: data['user'][0]['name'],
        time: data['createdAt'],
        xRay: data['xRay'],
        patientId: data['_id'],
        patientPhone: data['phone']);
  }
}
