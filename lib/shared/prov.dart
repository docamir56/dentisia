import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Prov with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;
  Future<void> jwtOrEmpty() async {
    var jwt = await storage.read(key: "jwt");
    token = jwt;
    notifyListeners();

    var id = jwt!.split(".");
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(id[1]))));
    uid = payload["id"];
    notifyListeners();
  }

  int? points;
  // Future<User> getUser() async {
  //   Map<String, dynamic> data = await API().get(
  //       url:
  //           'https://limitless-everglades-08570.herokuapp.com/api/v1/users/$uid',
  //       jwt: null);
  //   userName = data['name'];
  //   userPhoto = data['photo'];
  //   user = data;
  //   points = data['points']['surgery'] +
  //       data['points']['perio'] +
  //       data['points']['fixed'] +
  //       data['points']['surgery'] +
  //       data['points']['endo'] +
  //       data['points']['pedo'] +
  //       data['points']['xRay'] +
  //       data['points']['prothesis'];
  //   notifyListeners();
  //   return User.fromJson(data);
  // }

  String state = "All";
  get stateText => state;
  final List<String> stateList = [
    "All",
    "Surgery",
    "Endo",
    "Operative",
    "Pedo",
    "Fixed",
    "Ortho",
    "Removable",
    "Medicine",
    "X-ray"
  ];
  void click(String val) {
    state = val;
    notifyListeners();
  }

  String? createState;
  get createStateText => createState;
  final List<String> createStateList = [
    "surgery",
    "endo",
    "operative",
    "pedo",
    "prosthesis",
    "implant",
    "x-ray"
  ];
  void createClick(String val) {
    createState = val;
    notifyListeners();
  }

  String state2 = "Newest";
  get state2Text => state2;
  final List<String> state2List = ["Newest", "Popular"];
  void click2(String val) {
    state2 = val;
    notifyListeners();
  }

  String stateMarket = "State of item";
  get stateMartket => stateMarket;
  final List<String> stateMarketList = ["State of item", "New", "Used"];
  void onMarketChange(String val) {
    stateMarket = val;
    notifyListeners();
  }

  final PageController controller = PageController();

  int selectedPage = 0;
  void onPageChange(int index) {
    selectedPage = index;
    notifyListeners();
  }

  void onTap(int selectedIdex) {
    controller.jumpToPage(selectedIdex);
    notifyListeners();
  }

  String? firstHalf;
  String? secondHalf;

  bool flag = true;
}
