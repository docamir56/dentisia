class CaseModel {
  String content;
  List<dynamic> likes;
  String tag;
  String time;
  String userName;
  String uid;
  String userPhoto;
  List<dynamic> photos;
  String caseId;
  int commentCount;
  CaseModel({
    required this.caseId,
    required this.content,
    required this.likes,
    required this.userName,
    required this.userPhoto,
    required this.uid,
    required this.tag,
    required this.commentCount,
    required this.time,
    required this.photos,
  });

  factory CaseModel.fromJson({required Map<String, dynamic> data}) {
    return CaseModel(
      caseId: data['_id'],
      content: data['content'],
      likes: data['likes'],
      photos: data['photos'],
      userName: data['user'][0]['name'],
      userPhoto: data['user'][0]['photo'],
      tag: data['tag'],
      uid: data['user'][0]['_id'],
      time: data['createdAt'],
      commentCount: data['comments'].length,
    );
  }
}
