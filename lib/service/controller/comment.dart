import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/comment_model.dart';

class CommentService {
  Stream<List<Comment>> getCommentStream(
      {required String caseId, required String jwt}) async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) async {
      final data = await API().get(
          url:
              'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/$caseId/comments/',
          jwt: jwt);

      return data.map<Comment>((json) => Comment.fromJson(data: json)).toList();
    }).asyncMap((event) async => await event);
  }

  Future<dynamic> addComment(
      {
      // required String jwt,
      required String comment,
      required String uid,
      required String caseId}) async {
    Map<String, dynamic> data = await API().post(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/$caseId/comments/',
        body: {
          'comment': comment,
          'user': uid,
          'case': caseId,
          'createdAt': DateTime.now(),
        },
        token: null);
    return data;
  }
}
