// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dentisia/Screens/photo_viewer.dart';
// import 'package:dentisia/Screens/posts.dart';
// import 'package:dentisia/services/auth.dart';
// import 'package:dentisia/shared/const.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class UserProfile extends StatelessWidget {
//   const UserProfile({Key? key, required this.uid}) : super(key: key);
//   final String uid;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: appBar(""),
//       body: Center(
//         child: Column(
//           children: [
//             userData(),
//             const Divider(
//               thickness: 1,
//             ),
//             caseData(context),
//           ],
//         ),
//       ),
//     ));
//   }

//   Widget userData() {
//     return FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('user').doc(uid).get(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text("Something went wrong");
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic>? data =
//                 snapshot.data!.data() as Map<String, dynamic>?;
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {
//                       '${data!['photoUrl']}' != 'null'
//                           ? Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) =>
//                                   PhotoViewer(photourl: '${data['photoUrl']}')))
//                           : null;
//                     },
//                     child: CircleAvatar(
//                       radius: MediaQuery.of(context).size.aspectRatio * 120,
//                       backgroundColor: Colors.grey,
//                       backgroundImage: '${data!['photoUrl']}' == 'null'
//                           ? const AssetImage('images/user.jpg')
//                               as ImageProvider<Object>?
//                           : NetworkImage(
//                               '${data['photoUrl']}',
//                             ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child:
//                       TextWidget(item: 'Name : ', data: "${data['userName']}"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Wrap(
//                     spacing: 30,
//                     runAlignment: WrapAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child:
//                             TextWidget(item: 'Jop : ', data: '${data['jop']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextWidget(
//                             item: 'University : ',
//                             data: '${data['university']}'),
//                       ),
//                       //    TextWidget(item: 'Phone : ', data: '${data['phoneNum']}'),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Wrap(
//                     spacing: 20,
//                     runAlignment: WrapAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextWidget(
//                             item: 'Birthday : ', data: '${data['age']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextWidget(
//                             item: 'Points : ', data: '${data['point']}'),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.blue.shade400,
//               ),
//             );
//           }
//         });
//   }

//   Widget caseData(BuildContext context) {
//     final _auth = Provider.of<AuthBase>(context, listen: false);
//     return StreamBuilder<QuerySnapshot>(
//       stream: fireStore.collection('cases').orderBy('time').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.blue.shade900,
//             ),
//           );
//         } else if (snapshot.connectionState == ConnectionState.none) {
//           return const Center(
//             child: Text(
//               'Falied please check the connection',
//               style: TextStyle(color: Colors.red),
//             ),
//           );
//         } else if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator(
//             backgroundColor: Colors.blue.shade800,
//           ));
//         } else if (snapshot.hasError) {
//           return const Center(
//             child: Text(
//               'Some thing wrong is happened',
//               style: TextStyle(color: Colors.red),
//             ),
//           );
//         }
//         final posts = snapshot.data!.docs.reversed
//             .where((element) => element.data().toString().contains(uid));

//         List<PostContainer> postWidgets = [];
//         for (var post in posts) {
//           final postDetails = post.get('details');
//           final postsender = post.get('sender');
//           final uid = post.get('uid');
//           final postUrl = post.get('photoUrl');
//           final postTime = post.get('time');
//           final casePhotos = post.get('casesPhotos');
//           final email = _auth.currentUser!.email;
//           final postWidget = PostContainer(
//             text: postDetails,
//             time: postTime.toString().substring(0, 16),
//             sender: postsender,
//             photoUrl: postUrl,
//             postId: post.id,
//             uid: uid,
//             tag: post.get('tag'),
//             commentsCount: post.get('comments').toString(),
//             likesCount: (post.get('likes') as List).length.toString(),
//             liked: (post.get('likes') as List).contains(email),
//             user: _auth.currentUser!.uid,
//             cxt: context,
//             casePhotos: casePhotos,
//             email: '',
//           );
//           postWidgets.add(postWidget);
//         }
//         return Expanded(
//           child: ListView(
//             children: postWidgets,
//           ),
//         );
//       },
//     );
//   }
// }

// // class PostContainer extends StatelessWidget {
// //   final BuildContext? cxt;
// //   final List<dynamic> casePhotos;
// //   final String? text,
// //       time,
// //       user,
// //       sender,
// //       photoUrl,
// //       uid,
// //       email,
// //       postId,
// //       commentsCount,
// //       tag,
// //       likesCount;
// //   final bool? liked;

// //   const PostContainer(
// //       {Key? key,
// //       this.text,
// //       this.cxt,
// //       this.uid,
// //       this.user,
// //       this.time,
// //       this.sender,
// //       this.photoUrl,
// //       this.postId,
// //       this.tag,
// //       this.liked,
// //       this.email,
// //       this.commentsCount,
// //       required this.casePhotos,
// //       this.likesCount})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 15.0),
// //       child: Column(
// //         children: [
// //           ListTile(
// //               onTap: () {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                     builder: (context) => UserProfile(uid: uid!)));
// //               },
// //               leading: CircleAvatar(
// //                 backgroundColor: Colors.grey.shade100,
// //                 backgroundImage: photoUrl == null
// //                     ? const AssetImage('images/user.jpg')
// //                         as ImageProvider<Object>?
// //                     : NetworkImage(
// //                         photoUrl!,
// //                       ),
// //               ),
// //               title: Text(
// //                 sender!,
// //                 style: TextStyle(
// //                     color: Colors.blue.shade900,
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold),
// //               ),
// //               subtitle: Text(
// //                 time!,
// //               ),
// //               trailing: uid == user
// //                   ? IconButton(
// //                       icon: const Icon(
// //                         Icons.more_horiz,
// //                       ),
// //                       onPressed: () {
// //                         _showMenu(cxt!, postId!);
// //                       })
// //                   : null),
// //           Container(
// //               width: double.infinity,
// //               decoration: BoxDecoration(
// //                   color: Theme.of(context).colorScheme.secondary,
// //                   borderRadius: BorderRadius.circular(5)),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   text!,
// //                   textAlign: TextAlign.center,
// //                 ),
// //               )),
// //           casePhotos.isNotEmpty
// //               ? SizedBox(
// //                   height: 100,
// //                   child: ListView.builder(
// //                     scrollDirection: Axis.horizontal,
// //                     itemBuilder: (context, int index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(4.0),
// //                         child: InkWell(
// //                           onTap: () {
// //                             Navigator.of(context).push(MaterialPageRoute(
// //                                 builder: (context) => MultiPhotoViewer(
// //                                     galleryItems: casePhotos)));
// //                           },
// //                           child: Image.network(
// //                             casePhotos[index],
// //                             fit: BoxFit.cover,
// //                             loadingBuilder: (context, child, loadingProgress) {
// //                               if (loadingProgress == null) return child;
// //                               return const Center(
// //                                 child: CircularProgressIndicator(),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                     itemCount: casePhotos.length,
// //                     shrinkWrap: true,
// //                   ),
// //                 )
// //               : const Text(''),
// //           TextWidget(
// //             item: 'tag #',
// //             data: tag,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               TextButton.icon(
// //                 onPressed: () async {
// //                   if (!liked!) {
// //                     await fireStore.collection('cases').doc(postId).update({
// //                       'likes': FieldValue.arrayUnion([email])
// //                     });
// //                   } else {
// //                     await fireStore.collection('cases').doc(postId).update({
// //                       'likes': FieldValue.arrayRemove([email])
// //                     });
// //                   }
// //                 },
// //                 icon: Icon(
// //                   !liked! ? Icons.favorite_border_outlined : Icons.favorite,
// //                   color: Colors.pink,
// //                 ),
// //                 label: Text(likesCount!),
// //               ),
// //               TextButton.icon(
// //                 onPressed: () {
// //                   Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => Comments(
// //                                 postId: postId!,
// //                               )));
// //                 },
// //                 icon: Icon(Icons.comment, color: Colors.green.shade900),
// //                 label: Text(commentsCount!),
// //               )
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // void _showMenu(BuildContext context, String postId) {
// //   showModalBottomSheet(
// //       context: context,
// //       builder: (context) {
// //         return TextButton(
// //             onPressed: () async {
// //               try {
// //                 await fireStore
// //                     .collection('cases')
// //                     .doc(postId)
// //                     .collection('comments')
// //                     .get()
// //                     .then((value) {
// //                   for (DocumentSnapshot ds in value.docs) {
// //                     ds.reference.delete();
// //                   }
// //                 });
// //                 await fireStore.collection('cases').doc(postId).delete();
// //               } catch (e) {
// //                 print(e);
// //               } finally {
// //                 Navigator.of(context).pop();
// //               }
// //             },
// //             child: const Text('Delete'));
// //       });
// // }
