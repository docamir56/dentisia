import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static const route = '/notification';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar('Notification'),
      ),
    );
  }
}
