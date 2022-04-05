class News {
  String title;
  String details;
  int index;
  String ref;
  String time;
  News(
      {required this.title,
      required this.details,
      required this.index,
      required this.ref,
      required this.time});
  factory News.fromJson({required Map<String, dynamic> data}) {
    return News(
        details: data['details'],
        title: data['title'],
        index: data['index'],
        ref: data['ref'],
        time: data['createdAt']);
  }
}
