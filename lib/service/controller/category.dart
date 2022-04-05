import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/category.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategory({required String jwt}) async {
    final data = await API().get(
        url:
            'https://limitless-everglades-08570.herokuapp.com/api/v1/category/',
        jwt: jwt);

    return data
        .map<CategoryModel>((json) => CategoryModel.fromJson(data: json))
        .toList();
  }

  // List<CategoryModel> parseCategory(dynamic response) {
  //   final parse = jsonDecode(response).cast<Map<String, dynamic>>();
  //   return parse
  //       .map<CategoryModel>((json) => CategoryModel.fromJson(data: json))
  //       .toList();
  // }
}
