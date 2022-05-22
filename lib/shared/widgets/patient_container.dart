import 'package:dentisia/shared/const.dart';
import 'package:flutter/material.dart';

class PatientContainer extends StatelessWidget {
  final String name,
      uid,
      userId,
      postId,
      medical,
      time,
      dental,
      complain,
      age,
      phone,
      place,
      state,
      username;
  final bool puplic;
  final Function() onpress;

  const PatientContainer(
      {Key? key,
      this.puplic = true,
      required this.name,
      required this.postId,
      required this.state,
      required this.uid,
      required this.userId,
      required this.medical,
      required this.dental,
      required this.time,
      required this.complain,
      required this.age,
      required this.phone,
      required this.place,
      required this.onpress,
      required this.username})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(item: 'Shared by Dr: ', data: username),
                            Text(
                              time,
                            ),
                          ],
                        ),
                        if (uid == userId)
                          IconButton(
                              icon: const Icon(
                                Icons.more_horiz,
                              ),
                              onPressed: () {
                                _showMenu(context, postId);
                              }),
                      ],
                    ),
                    TextWidget(
                      item: 'Patient Name : ',
                      data: name,
                    ),
                    TextWidget(
                      item: 'Medical history : ',
                      data: medical,
                    ),
                    TextWidget(
                      item: 'Dental history : ',
                      data: dental,
                    ),
                    TextWidget(
                      item: 'Chief complain : ',
                      data: complain,
                    ),
                    TextWidget(
                      item: 'Patient age : ',
                      data: age,
                    ),
                    TextWidget(
                      item: 'Patient phone : ',
                      data: puplic ? '****' : phone,
                    ),
                    TextWidget(
                      item: 'Patient place : ',
                      data: place,
                    ),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // if (puplic)
              //   OutlinedButton(
              //     child: const Text(
              //       'Refer?',
              //       style: TextStyle(color: Colors.blue),
              //     ),
              //     onPressed: () {},
              //   ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: OutlinedButton(
                  child: Text(
                    state,
                    style: const TextStyle(color: Colors.green),
                  ),
                  onPressed: onpress,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void _showMenu(BuildContext context, String postId) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return TextButton(
            onPressed: () async {
              try {
                // await fireStore.collection('patient').doc(postId).delete();
              } catch (e) {
                throw Exception('$e');
              } finally {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Delete'));
      });
}
