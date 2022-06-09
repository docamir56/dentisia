import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CaseDetails extends StatelessWidget {
  static const route = '/caseDetails';
  const CaseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(""),
      ),
    );
  }
}
