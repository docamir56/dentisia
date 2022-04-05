class Answer {
  String a;
  String b;
  String c;
  String d;
  Answer({required this.a, required this.b, required this.c, required this.d});
  factory Answer.fromJson({required Map<String, dynamic> data}) {
    return Answer(a: data['a'], b: data['b'], c: data['c'], d: data['d']);
  }
}
