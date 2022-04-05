import 'package:dentisia/shared/const.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static const route = '/search';

  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Expanded(
                    child: TextF(_searchController, "Enter your search",
                        hint: 'Search ',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.search),
                          ),
                        ),
                        keybord: TextInputType.text, onchange: (value) {
                      setState(() {
                        _searchController.text = value;
                      });
                    }),
                  ),
                ],
              ),
              // search(context, _searchController.text),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget search(BuildContext context, String search) {
//   return StreamBuilder<d>(
//     stream: fireStore
//         .collection('user')
//         .where('userName', isEqualTo: search)
//         .snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return const Center(
//           child: Text(
//             'User not found',
//           ),
//         );
//       }
//       final posts = snapshot.data!.docs;

//       List<SearchContainer> postWidgets = [];
//       for (var post in posts) {
//         final name = post.get('userName');
//         final photo = post.get('photoUrl');
//         final university = post.get('university');

//         final postWidget = SearchContainer(
//           name: name,
//           cxt: context,
//           uid: post.id,
//           photo: photo,
//           university: university,
//         );
//         postWidgets.add(postWidget);
//       }
//       return Expanded(
//         child: ListView(
//           children: postWidgets,
//         ),
//       );
//     },
//   );
// }

class SearchContainer extends StatelessWidget {
  final String? name, photo, uid, university;
  final BuildContext? cxt;

  const SearchContainer({
    Key? key,
    this.name,
    this.cxt,
    this.uid,
    this.photo,
    this.university,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
        child: ListTile(
            // onTap: () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => UserProfile(uid: uid!)));
            // },
            leading: CircleAvatar(
              backgroundImage: photo != "null"
                  ? NetworkImage(photo!) as ImageProvider<Object>?
                  : const AssetImage('images/user.jpg'),
            ),
            title: Text(name!),
            subtitle: Text(university!)));
  }
}
