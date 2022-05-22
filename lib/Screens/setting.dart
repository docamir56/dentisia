import 'package:dentisia/Screens/about.dart';
import 'package:dentisia/Screens/edit_profile.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  static const route = '/setting';
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBar('Setting'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProfile.route);
                  },
                  icon: const Icon(
                    Icons.account_box_outlined,
                    size: 28,
                  ),
                  label: const Text(
                    "Edit your profile information",
                    // textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
              const SizedBox(height: 15),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.vpn_key_outlined,
                    size: 28,
                  ),
                  label: const Text(
                    "Edit your password",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
              const SizedBox(height: 15),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_bank_outlined,
                    size: 28,
                  ),
                  label: const Text(
                    "Contact us",
                    // textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
              const SizedBox(height: 15),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(About.route);
                  },
                  icon: const Icon(
                    Icons.contact_support_outlined,
                    size: 28,
                  ),
                  label: const Text(
                    "About us",
                    // textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
              const SizedBox(height: 15),
              TextButton.icon(
                  onPressed: () {
                    // Navigator.of(context).pushNamed(About.route);
                  },
                  icon: const Icon(
                    Icons.privacy_tip_outlined,
                    size: 28,
                  ),
                  label: const Text(
                    "Privacy and terms",
                    // textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ],
          )),
    );
  }
}
