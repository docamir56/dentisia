import 'package:dentisia/service/controller/comment.dart';
import 'package:dentisia/service/model/comment_model.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  static const route = '/comments';
  final String caseId;

  Comments({Key? key, required this.caseId}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: appBar('Comments'),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommentStream(
                caseId: caseId,
                jwt: _prov.token!,
                uid: _prov.uid!,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: StatefulBuilder(
                    builder: (context, StateSetter setState) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextF(
                            _commentController,
                            "Enter your comment",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.play_arrow_sharp,
                                  color: Colors.blue.shade900),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await CommentService().addComment(
                                        // jwt: _prov.token!,
                                        comment: _commentController.text,
                                        uid: _prov.uid!,
                                        caseId: caseId);

                                    // });
                                  } finally {
                                    setState(() {
                                      _commentController.clear();
                                    });
                                  }
                                }
                              },
                            ),
                            hint: 'Write your comment please..',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentStream extends StatelessWidget {
  final String jwt;
  final String caseId;
  final String uid;
  const CommentStream(
      {Key? key, required this.caseId, required this.jwt, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Comment>>(
        stream: CommentService().getCommentStream(caseId: caseId, jwt: jwt),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              'There is no comments here !!',
              style: TextStyle(color: Colors.red),
            ));
          } else if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data;
            return Expanded(
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, i) {
                    return CommentContainer(
                      commentId: data[i].commentId,
                      caseId: data[i].caseId,
                      comment: data[i].comment,
                      time: data[i].time,
                      uid: uid,
                      userId: data[i].uid,
                      userName: data[i].userName,
                    );
                  }),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
                child: Text(
              'There is problem with the connection , please try again !!',
              style: TextStyle(color: Colors.red),
            ));
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: const TextStyle(color: Colors.red),
            ));
          } else {
            return const Center(
              child: Text('there is something is wrong'),
            );
          }
        });
  }
}

class CommentContainer extends StatelessWidget {
  final String comment, uid, userId, time, caseId, userName, commentId;
  final String? photoUrl;

  const CommentContainer(
      {Key? key,
      required this.comment,
      required this.uid,
      required this.caseId,
      required this.time,
      required this.userId,
      required this.commentId,
      required this.userName,
      this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    // trailing: uid == userId
                    //     ? IconButton(
                    //         icon: const Icon(
                    //           Icons.more_horiz,
                    //         ),
                    //         onPressed: () {
                    //           // _showMenu(context, caseId, commentId);
                    //         })
                    //     : Container(),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
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
                          color: Colors.blue.shade800,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      comment,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

// void _showMenu(BuildContext context, String postId, String commentId) {
//   showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return TextButton(
//             onPressed: () async {
//               // try {
//               //   await fireStore
//               //       .collection('cases')
//               //       .doc(postId)
//               //       .collection('comments')
//               //       .doc(commentId)
//               //       .delete();
//               //   await fireStore
//               //       .collection('cases')
//               //       .doc(postId)
//               //       .update({'comments': FieldValue.increment(-1)});
//               // } finally {
//               //   Navigator.pop(context);
//               // }
//             },
//             child: const Text('Delete'));
//       });
// }
