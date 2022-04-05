class User {
  String name;
  String age;
  String university;
  String speciality;
  int phone;
  String email;
  String id;
  Map<String, dynamic> points;
  String role;
  String photo;
  User(
      {required this.name,
      required this.age,
      required this.university,
      required this.speciality,
      required this.phone,
      required this.email,
      required this.id,
      required this.points,
      required this.role,
      required this.photo});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      age: data['age'],
      email: data['email'],
      id: data['_id'],
      points: data['points'],
      name: data['name'],
      phone: data['phone'],
      photo: data['photo'],
      role: data['role'],
      speciality: data['speciality'],
      university: data['university'],
    );
  }
}
