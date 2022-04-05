// import 'dart:convert';

// import 'package:dentisia/Screens/home.dart';
// import 'package:dentisia/Screens/sign_in.dart';
// import 'package:dentisia/Screens/splash.dart';
// import 'package:dentisia/shared/prov.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';

// class Landing extends StatelessWidget {
//   static const route = '/landing';
//   final storage = const FlutterSecureStorage();

//   Future<String> get jwtOrEmpty async {
//     var jwt = await storage.read(key: "jwt");
//     if (jwt == null) return "";
//     return jwt;
//   }

//   const Landing({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final _prov = Provider.of<Prov>(context, listen: false);
//     return FutureBuilder(
//         future: jwtOrEmpty,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const SplashScreen();
//           }
//           if (snapshot.data != "" || snapshot.data != null) {
//             var str = snapshot.data as String;
//             var jwt = str.split(".");

//             if (jwt.length != 3) {
//               return const SignIn();
//             } else {
//               var payload = json.decode(
//                   ascii.decode(base64.decode(base64.normalize(jwt[1]))));

//               if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
//                   .isAfter(DateTime.now())) {
//                 _prov.uid = payload["id"];
//                 _prov.jwtOrEmpty();
//                 _prov.getUser();
//                 return Home();
//               } else {
//                 return const SignIn();
//               }
//             }
//           } else {
//             return const SignIn();
//           }
//         });
//   }
// }
