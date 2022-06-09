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
          .map<CaseModel>(
              (json) => CaseModel.fromJson(data: json, isPublic: true))
          .toList();
    }).asyncMap((event) async => await event);
  }

  Future<List<CaseModel>> getMyCases(String uid) async {
    final data = await API().get(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/$uid',
        jwt: null);
    List<CaseModel> caseList = [];
    for (int i = 0; i < data.length; i++) {
      caseList.add(CaseModel.fromJson(data: data[i], isPublic: false));
    }
    return caseList;
  }

  Future<dynamic> addCase(
      {required String desc,
      required String tag,
      required String medicalHistory,
      required String caseName,
      required bool public,
      required String uid}) async {
    Map<String, dynamic> data = await API().post(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/',
        body: {
          'desc': desc,
          'medicalHistory': medicalHistory,
          'caseName': caseName,
          'public': public,
          'tag': tag,
          'user': uid,
          'createdAt': DateTime.now().toString(),
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
