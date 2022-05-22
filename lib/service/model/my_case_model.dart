class MyCaseModel {
  String desc;
  String caseName;
  List<dynamic> likes;
  String tag;
  String time;

  String medicalHistory;

  List<dynamic> photos;
  String caseId;
  int commentCount;

  MyCaseModel({
    required this.caseId,
    required this.caseName,
    required this.desc,
    required this.likes,
    required this.medicalHistory,
    required this.tag,
    required this.commentCount,
    required this.time,
    required this.photos,
  });

  factory MyCaseModel.fromMyJson({required Map<String, dynamic> data}) {
    return MyCaseModel(
        caseId: data['_id'],
        desc: data['desc'],
        medicalHistory: data['medicalHistory'],
        likes: data['likes'],
        photos: data['photos'],
        tag: data['tag'],
        time: data['createdAt'],
        commentCount: data['comments'].length,
        caseName: data['caseName']);
  }
}
