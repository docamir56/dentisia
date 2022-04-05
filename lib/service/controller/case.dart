import 'dart:async';
import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/case_model.dart';

class CaseService {
  Stream<List<CaseModel>> getCaseStream({required String jwt}) async* {
    yield* Stream.periodic(const Duration(), (_) async {
      final data = await API().get(
          url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/',
          jwt: jwt);
      return data
          .map<CaseModel>((json) => CaseModel.fromJson(data: json))
          .toList();
    }).asyncMap((event) async => await event);
  }

  Future<List<CaseModel>> getAllCases({required String jwt}) async {
    final data = await API().get(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/',
        jwt: jwt);
    List<CaseModel> caseList = [];
    for (int i = 0; i < data.length; i++) {
      caseList.add(CaseModel.fromJson(data: data[i]));
    }
    return caseList;
  }

  Future<dynamic> addCase(
      {required String content,
      required String tag,
      required String uid}) async {
    Map<String, dynamic> data = await API().post(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/',
        body: {
          'content': content,
          'tag': tag,
          'user': uid,
          'createdAt': DateTime.now(),
        },
        token: null);
    return data;
  }

  Future<dynamic> patchLike(
      {required String token,
      required String caseId,
      required Map<String, dynamic> body}) async {
    var data = await API().patch(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/$caseId',
        body: body,
        token: token);
    return data;
  }
}
