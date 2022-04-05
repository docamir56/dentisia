import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/user_model.dart';

class UserService {
  Stream<User> getUserStream(
      {required String uid, required String jwt}) async* {
    yield* Stream.periodic(const Duration(seconds: 3), (_) async {
      final data = await API().get(
          url:
              'https://limitless-everglades-08570.herokuapp.com/api/v1/users/$uid',
          jwt: jwt);

      return User.fromJson(data);
    }).asyncMap((event) async => await event);
  }

  Future<User> getUser({required String uid}) async {
    final data = await API().get(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/users/$uid',
        jwt: null);

    return User.fromJson(data);
  }
}
