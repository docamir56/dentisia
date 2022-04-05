import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/news_model.dart';

class NewsService {
  Future<List<News>> getnews({required String jwt}) async {
    final data = await API().get(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/news/',
        jwt: jwt);

    return data.map<News>((json) => News.fromJson(data: json)).toList();
  }
}
