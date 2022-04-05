class Quiz {
  String category;
  String question;
  Map<String, dynamic> answer;
  String correctA;
  Quiz(
      {required this.category,
      required this.question,
      required this.answer,
      required this.correctA});
  factory Quiz.fromJson(Map<String, dynamic> data) {
    return Quiz(
      answer: data['answer'],
      question: data['question'],
      category: data['category'],
      correctA: data['correctA'],
    );
  }
}
