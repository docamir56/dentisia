import 'package:dentisia/service/api.dart';
import 'package:flutter/material.dart';

Future<dynamic> showBottomMenu(
    {required BuildContext context, required String url, required String jwt}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextButton(
            //     onPressed: () async {},
            //     child: const Text(
            //       'Report',
            //       style: TextStyle(color: Colors.black),
            //     )),
            TextButton(
                onPressed: () async {},
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () async {
                  await API().delete(url: url, jwt: jwt);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        );
      });
}
