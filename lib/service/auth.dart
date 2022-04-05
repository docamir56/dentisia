import 'package:dentisia/service/api.dart';

class Auth {
  Future<String> login(
      {required String email, required String password}) async {
    Map<String, dynamic> data = await API().post(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/users/login',
        body: {'email': email, 'password': password},
        token: null);

    String token = data['token']!;

    return token;
  }

  Future<String> signup(
      {required String email,
      required String name,
      required String age,
      required String university,
      required String speciality,
      required int phone,
      required String passwordConfirmation,
      required String password}) async {
    Map<String, dynamic> data = await API().post(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/users/signup',
        body: {
          'name': name,
          'age': age,
          'university': university,
          'speciality': speciality,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation
        },
        token: null);

    String token = data['token']!;

    return token;
  }
}
