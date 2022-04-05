import 'package:dentisia/service/controller/news.dart';
import 'package:dentisia/service/model/news_model.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:flutter/material.dart';
import 'package:dentisia/shared/const.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  static const route = '/news';

  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<List<News>>(
              future: NewsService().getnews(jwt: _prov.token!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ));
                }
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                    'There is no news to share!',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ));
                } else {
                  final data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        return NewsContainer(
                          details: data[i].details,
                          ref: data[i].ref,
                          title: data[i].title,
                        );
                      });
                }
              })
          // StreamBuilder<dynamic>(
          //   stream:
          //       // _fireStore.collection('news').orderBy('index').snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           backgroundColor: Colors.blue.shade400,
          //         ),
          //       );
          //     }
          //     final posts = snapshot.data!.docs.reversed;
          //     List<PostContainer> postWidgets = [];
          //     for (var post in posts) {
          //       final postDetails = post.get('details');
          //       final postSender = post.get('title');
          //       final ref = post.get('referance');

          //       final postWidget = PostContainer(
          //         details: postDetails,
          //         title: postSender,
          //         ref: ref,
          //       );
          //       postWidgets.add(postWidget);
          //     }
          //     return Expanded(
          //       child: ListView(
          //         children: postWidgets,
          //       ),
          //     );
          //   },
          // )

          ),
    );
  }
}

class NewsContainer extends StatefulWidget {
  final String details, title, ref;
  const NewsContainer(
      {Key? key, required this.title, required this.details, required this.ref})
      : super(key: key);

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.details.length > 300) {
      firstHalf = widget.details.substring(0, 300);
      secondHalf = widget.details.substring(300, widget.details.length);
    } else {
      firstHalf = widget.details;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      secondHalf!.isEmpty
                          ? Text(firstHalf!)
                          : Column(
                              children: <Widget>[
                                Text(flag
                                    ? (firstHalf! + "...")
                                    : (firstHalf! + secondHalf!)),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        flag ? "show more" : "show less",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                ),
                              ],
                            )
                    ],
                  ))),
          TextWidget(
            item: 'Referance : ',
            data: widget.ref,
          )
        ],
      ),
    );
  }
}
