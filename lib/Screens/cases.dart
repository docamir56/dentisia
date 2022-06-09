import 'package:dentisia/Screens/add_case.dart';
import 'package:dentisia/Screens/notification.dart';
import 'package:dentisia/Screens/profile.dart';
import 'package:dentisia/Screens/search.dart';
import 'package:dentisia/service/controller/case.dart';
import 'package:dentisia/service/model/case_model.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/widgets/post_container.dart';

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Prov>(context);
    return SafeArea(
        child: Scaffold(
            appBar: appBar(
              'Dentisia',
              center: false,
              action: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, NewPost.route);
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Profile.route);
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.green.shade900,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Search.route);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.green.shade900,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, NotificationPage.route);
                    },
                    icon: Icon(Icons.notifications_active_outlined,
                        color: Colors.green.shade900)),
              ],
            ),
            body: StreamBuilder<List<CaseModel>>(
                stream: CaseService().getCaseStream(jwt: prov.token!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      snapshot.error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ));
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                        child: Text(
                            'there is something is wrong with the connection'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: PostContainer(
                              isPublic: true,
                              medicalHistory: snapshot.data![i].medicalHistory,
                              likesList: snapshot.data![i].likes,
                              desc: snapshot.data![i].desc,
                              casePhotos: snapshot.data![i].photos,
                              uid: snapshot.data![i].uid,
                              commentsCount:
                                  snapshot.data![i].commentCount.toString(),
                              likesCount:
                                  snapshot.data![i].likes.length.toString(),
                              userName: snapshot.data![i].userName,
                              tag: snapshot.data![i].tag,
                              time: snapshot.data![i].time
                                  .substring(0, 16)
                                  .replaceAll(RegExp(r'T'), '  '),
                              caseId: snapshot.data![i].caseId,
                            ),
                          );
                        });
                  } else {
                    return const Center(child: Text('there is no case found'));
                  }
                })));
  }
}
