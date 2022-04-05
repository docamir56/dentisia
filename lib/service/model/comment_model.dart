class Comment {
  String comment;
  String uid;
  String userName;
  String userPhoto;
  String commentId;
  String caseId;
  String time;
  List<dynamic> likes;

  Comment(
      {required this.comment,
      required this.uid,
      required this.userName,
      required this.userPhoto,
      required this.commentId,
      required this.caseId,
      required this.time,
      required this.likes});

  factory Comment.fromJson({required Map<String, dynamic> data}) {
    return Comment(
      comment: data['comment'],
      time: data['createdAt'],
      commentId: data['_id'],
      likes: data['commentLikes'],
      uid: data['user'][0]['_id'],
      userName: data['user'][0]['name'],
      userPhoto: data['user'][0]['photo'],
      caseId: data['case'],
    );
  }
}
