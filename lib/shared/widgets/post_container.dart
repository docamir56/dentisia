import 'package:dentisia/Screens/comments.dart';
import 'package:dentisia/service/controller/case.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/show_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostContainer extends StatelessWidget {
  final List<dynamic> casePhotos;
  final String? photoUrl;
  final String text,
      time,
      userName,
      uid,
      caseId,
      commentsCount,
      tag,
      likesCount;

  final List<dynamic> likesList;
  final String jwt;
  const PostContainer(
      {Key? key,
      required this.text,
      required this.likesList,
      required this.time,
      required this.userName,
      this.photoUrl,
      required this.caseId,
      required this.tag,
      required this.jwt,
      required this.uid,
      required this.commentsCount,
      required this.casePhotos,
      required this.likesCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Prov>(context);
    return Column(
      children: [
        Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => UserProfile(uid: uid)));
                    // },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: photoUrl == null
                          ? const AssetImage('images/user.png')
                              as ImageProvider<Object>?
                          : NetworkImage(
                              photoUrl!,
                            ),
                    ),
                    title: Text(
                      userName,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      time,
                    ),
                    trailing: uid == prov.uid
                        ? IconButton(
                            icon: const Icon(
                              Icons.more_horiz,
                            ),
                            onPressed: () async {
                              await showBottomMenu(
                                  context: context,
                                  url:
                                      'https://limitless-everglades-08570.herokuapp.com/api/v1/cases/$caseId',
                                  jwt: prov.token!);
                            })
                        : null),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                      ),
                      // casePhotos.isNotEmpty
                      //     ? SizedBox(
                      //         height: 100,
                      //         child: ListView.builder(
                      //           scrollDirection: Axis.horizontal,
                      //           itemBuilder: (context, int index) {
                      //             return Padding(
                      //               padding: const EdgeInsets.all(4.0),
                      //               child: InkWell(
                      //                 onTap: () {
                      //                   Navigator.of(context).push(
                      //                       MaterialPageRoute(
                      //                           builder: (context) =>
                      //                               MultiPhotoViewer(
                      //                                   galleryItems:
                      //                                       casePhotos)));
                      //                 },
                      //                 child: Image.network(
                      //                   casePhotos[index],
                      //                   fit: BoxFit.cover,
                      //                   loadingBuilder:
                      //                       (context, child, loadingProgress) {
                      //                     if (loadingProgress == null) {
                      //                       return child;
                      //                     }
                      //                     return const Center(
                      //                       child: CircularProgressIndicator(),
                      //                     );
                      //                   },
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //           itemCount: casePhotos.length,
                      //           shrinkWrap: true,
                      //         ),
                      //       )
                      //     : Container(),
                      const SizedBox(height: 5),
                      TextWidget(
                        item: 'tag #',
                        data: tag,
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () async {
                if (likesList.contains(prov.uid)) {
                  likesList.remove(prov.uid);
                  await CaseService().patchLike(
                      token: jwt, caseId: caseId, body: {'likes': likesList});
                } else {
                  likesList.add(prov.uid);
                  await CaseService().patchLike(
                      token: jwt, caseId: caseId, body: {'likes': likesList});
                }
              },
              icon: Icon(
                !likesList.any((element) => element == prov.uid)
                    ? Icons.thumb_up_alt_outlined
                    : Icons.thumb_up,
                color: Colors.pink,
              ),
              label: Text(likesCount),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Comments(
                              caseId: caseId,
                            )));
              },
              icon: Icon(Icons.maps_ugc_outlined, color: Colors.green.shade900),
              label: Text(commentsCount),
            )
          ],
        ),
      ],
    );
  }
}
