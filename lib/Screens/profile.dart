import 'package:dentisia/Screens/my_cases.dart';
import 'package:dentisia/Screens/setting.dart';
import 'package:dentisia/Screens/sign_in.dart';
import 'package:dentisia/service/controller/uers.dart';
import 'package:dentisia/service/model/user_model.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final storage = const FlutterSecureStorage();
  static const route = '/profile';

  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storage = const FlutterSecureStorage();
  final bool _isLoading = false;

  // late File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      appBar: appBar('Profile'),
      body: FutureBuilder<User>(
          future: UserService().getUser(uid: _prov.uid!),
          builder: ((context, snapshot) {
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
                ),
              );
            } else {
              final data = snapshot.data;
              return Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              )
                            : InkWell(
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius:
                                      MediaQuery.of(context).size.aspectRatio *
                                          120,
                                  backgroundImage: data!.photo == 'user.jpg'
                                      ? const AssetImage('images/user.png')
                                          as ImageProvider<Object>?
                                      : NetworkImage(
                                          data.photo,
                                        ),
                                ),
                                onTap: () {
                                  // '${data.photo}' != 'null'
                                  //     ? Navigator.of(context).push(
                                  //         MaterialPageRoute(
                                  //             builder: (context) => PhotoViewer(
                                  //                 photourl:
                                  //                     '${data['photoUrl']}')))
                                  //     : null;
                                },
                              )),
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                        // getImage(context, _auth.currentUser!);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        border: Border.all(
                            color: Colors.blue.withAlpha(80), width: 2)),
                    // padding: padding ?? const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextWidget(item: 'Name : ', data: data!.name),
                          TextWidget(
                              item: 'Speciality : ', data: data.speciality),
                          TextWidget(
                              item: 'University : ', data: data.university),
                          TextWidget(
                              item: 'Phone : ', data: data.phone.toString()),
                          TextWidget(item: 'Birthday : ', data: data.age),
                          // TextWidget(
                          //     item: 'Points : ', data: data.points.toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // OutlinedButton(onPressed: () {}, child: Text('Setting')),
                              materialButton(
                                () => Navigator.of(context)
                                    .pushNamed(MyCases.route),
                                "My Cases",
                              ),
                              materialButton(
                                () => Navigator.of(context)
                                    .pushNamed(Setting.route),
                                "Setting",
                              ),

                              materialButton(() async {
                                try {
                                  await storage.delete(key: "jwt");

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      SignIn.route,
                                      (Route<dynamic> route) => false);
                                } catch (e) {
                                  throw Exception('$e');
                                }
                              }, 'Log out')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            }
          })),
    ));
  }

  // Future getImage(BuildContext cxt, User user) async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //       _isLoading = true;
  //     });

  //     await addProfilePic(user, cxt);
  //   } else {
  //     print('No image selected.');
  //   }
  // }

  // Future<String> addProfilePic(User user, BuildContext cxt) async {
  //   String url = "";
  //   File compressedImage =
  //       await CompressImage().compressImage(imageFile: _image);
  //   Reference ref = FirebaseStorage.instance
  //       .ref()
  //       .child("profile")
  //       .child('pic')
  //       .child(user.uid);
  //   TaskSnapshot taskSnapshot =
  //       await ref.putFile(compressedImage).whenComplete(() {
  //     print('profile is Uploaded');
  //   });
  //   url = await taskSnapshot.ref.getDownloadURL();

  //   await user.updatePhotoURL(url);

  //   await fireStore
  //       .collection('user')
  //       .doc(user.uid)
  //       .update({'photoUrl': url}).whenComplete(() => ScaffoldMessenger.of(cxt)
  //           .showSnackBar(const SnackBar(content: Text('photo is Uploaded'))));
  //   setState(() {
  //     _isLoading = false;
  //   });

  //   return url;
  // }
}
