import 'package:dentisia/service/api.dart';
import 'package:dentisia/service/model/quiz.dart';

class QuizService {
  Future<List<Quiz>> getQuiz() async {
    final data = await API().get(
        url: 'https://limitless-everglades-08570.herokuapp.com/api/v1/quiz/',
        jwt: null);

    return data.map<Quiz>((json) => Quiz.fromJson(json)).toList();
  }
}
