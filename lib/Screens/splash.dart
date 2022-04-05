import 'dart:async';

import 'package:dentisia/Screens/home.dart';
import 'package:dentisia/Screens/sign_in.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

const riveFile = 'images/dentisia.riv';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RiveAnimationController? _animationController;
  Artboard? _artboard;
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    _time();
    _loadRiveFile();
    super.initState();
  }

  _time() async {
    String? jwt = await storage.read(key: "jwt");
    final _prov = Provider.of<Prov>(context, listen: false);
    return Timer(const Duration(seconds: 3), () {
      if (jwt != null) {
        var token = jwt.split(".");
        if (token.length != 3) {
          Navigator.of(context).pushReplacementNamed(SignIn.route);
        } else {
          // var payload = json
          //     .decode(ascii.decode(base64.decode(base64.normalize(token[1]))));
          // _prov.uid = payload["id"];
          _prov.jwtOrEmpty();
          // _prov.getUser();
          Navigator.of(context).pushReplacementNamed(Home.routeId);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(SignIn.route);
      }
    });
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFile);
    RiveFile rFile = RiveFile.import(bytes);
    setState(() => _artboard = rFile.mainArtboard
      ..addController(_animationController = SimpleAnimation('loading')));
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
            height: 100,
            width: 100,
            child: _artboard != null
                ? Rive(artboard: _artboard!)
                : CircularProgressIndicator(
                    color: Colors.blue.shade900,
                  )),
      ),
    );
  }
}
