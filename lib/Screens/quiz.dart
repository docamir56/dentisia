import 'dart:async';
import 'package:dentisia/service/controller/quiz.dart';
import 'package:dentisia/service/model/quiz.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  static const route = '/quiz';
  const QuizPage({
    Key? key,
  }) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int marks = 0;
  bool isloading = false;
  Map<String, Color> btncolor = {
    "a": Colors.white,
    "b": Colors.white,
    "c": Colors.white,
    "d": Colors.white,
  };

  int index = 0;

  @override
  Widget build(BuildContext context) {
    // final _prov = Provider.of<Prov>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments;

    return SafeArea(
        child: Scaffold(
            appBar: appBar('Quiz', action: [
              TextButton(
                  onPressed: index == 0
                      ? null
                      : () {
                          setState(() {
                            index--;
                          });
                        },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Previos'),
                  ))
            ]),
            body: FutureBuilder<List<Quiz>>(
                future: QuizService().getQuiz(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.black),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('There is no question bank here'));
                  } else {
                    final data = snapshot.data!
                        .where((element) =>
                            element.category.contains(categoryName.toString()))
                        .toList();
                    if (data.isEmpty) {
                      return const Center(
                          child: Text('There is no question bank here'));
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[index].question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.aspectRatio * 60,
                          ),
                          answerButton('a', data),
                          answerButton('b', data),
                          answerButton('c', data),
                          answerButton('d', data),
                        ],
                      ),
                    );
                  }
                })));
  }

  void checkanswer(String k, List<Quiz> _category) async {
    setState(() {
      isloading = true;
    });
    if (_category[index].correctA == k) {
      setState(() {
        btncolor[k] = Colors.green;
        marks++;
      });
    } else {
      setState(() {
        btncolor[k] = Colors.red;
      });
    }
    await Future.delayed(const Duration(milliseconds: 800));

    nextquestion(_category);
    setState(() {
      isloading = false;
    });
  }

  void nextquestion(List<Quiz> _category) {
    setState(() {
      if (index < _category.length - 1) {
        index++;
      } else {
        try {
          // fireStore
          //     .collection('user')
          //     .doc(_auth.currentUser!.uid)
          //     .update({'point': FieldValue.increment(marks)});
        } catch (e) {
          throw Exception('$e');
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('You Points'),
            content: Text(marks.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    index = 0;
                    marks = 0;
                  });
                },
                child: const Text('Again'),
              )
            ],
          ),
        );
      }
      btncolor['a'] = Colors.white;
      btncolor['b'] = Colors.white;
      btncolor['c'] = Colors.white;
      btncolor['d'] = Colors.white;
    });
  }

  Widget answerButton(String k, List<Quiz> _category) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: isloading ? null : () => checkanswer(k, _category),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _category[index].answer[k]!,
          ),
        ),
        disabledColor: btncolor[k],
        color: Colors.white,
        minWidth: 200.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
