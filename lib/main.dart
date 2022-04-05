import 'package:dentisia/Screens/about.dart';
import 'package:dentisia/Screens/categories.dart';
import 'package:dentisia/Screens/conform.dart';
import 'package:dentisia/Screens/create_market.dart';
import 'package:dentisia/Screens/create_patient.dart';
import 'package:dentisia/Screens/forget.dart';
import 'package:dentisia/Screens/home.dart';
import 'package:dentisia/Screens/market.dart';
import 'package:dentisia/Screens/my_patient.dart';
import 'package:dentisia/Screens/news.dart';
import 'package:dentisia/Screens/notification.dart';
import 'package:dentisia/Screens/patient.dart';
import 'package:dentisia/Screens/profile.dart';
import 'package:dentisia/Screens/quiz.dart';
import 'package:dentisia/Screens/search.dart';
import 'package:dentisia/Screens/edit_profile.dart';
import 'package:dentisia/Screens/setting.dart';
import 'package:dentisia/Screens/sign_in.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:flutter/material.dart';
import 'package:dentisia/Screens/splash.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/add_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Prov>(
      create: (context) => Prov(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.blueGrey.shade50),

          // const Color(0xffDCE3F0)
        ),
        initialRoute: SplashScreen.route,
        routes: {
          Home.routeId: (context) => Home(),
          About.route: (context) => const About(),
          Categories.route: (context) => const Categories(),
          ConfirmEmail.route: (context) => const ConfirmEmail(),
          SignIn.route: (context) => const SignIn(),
          ForgotPassword.route: (context) => const ForgotPassword(),
          MarketPage.route: (context) => const MarketPage(),
          NewsPage.route: (context) => const NewsPage(),
          PatientPage.route: (context) => const PatientPage(),
          Profile.route: (context) => const Profile(),
          QuizPage.route: (context) => const QuizPage(),
          Search.route: (context) => const Search(),
          EditProfile.route: (context) => const EditProfile(),
          Setting.route: (context) => const Setting(),
          SplashScreen.route: (context) => const SplashScreen(),
          NewPost.route: (context) => const NewPost(),
          CreateItem.route: (context) => const CreateItem(),
          CreatePatient.route: (context) => CreatePatient(),
          NotificationPage.route: (context) => const NotificationPage(),
          MyPatient.route: (context) => const MyPatient(),
          // Landing.route: (context) => const Landing(),
        },
      ),
    );
  }
}
