// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dentisia/service/controller/case.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  static const route = '/post';

  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<File> _imageList = [];
  String? url;
  bool uploading = false;
  double val = 0;
  final TextEditingController _postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final _auth = Provider.of<AuthBase>(context, listen: false);
    return SafeArea(
        child: Form(
            key: _formKey,
            child: Consumer<Prov>(
              builder: (context, prov, child) {
                return Scaffold(
                    appBar: appBar(
                      'create new case',
                      //  action: [
                      //   TextButton(
                      //       onPressed: uploading
                      //           ? null
                      //           : () async {
                      //               if (_formKey.currentState!.validate()) {
                      //                 try {
                      //                   if (_imageList.isNotEmpty) {
                      //                     setState(() {
                      //                       uploading = true;
                      //                     });
                      //                     await uploadFile();
                      //                   }
                      //                   await imgRef!.doc().set({
                      //                     'details': _postController.text,
                      //                     'time': DateTime.now().toString(),
                      //                     'photoUrl': _auth.currentUser!.photoURL,
                      //                     'sender':
                      //                         _auth.currentUser!.displayName,
                      //                     'comments': 0,
                      //                     'likes': [],
                      //                     'casesPhotos':
                      //                         _urlList.isNotEmpty ? _urlList : [],
                      //                     'uid': _auth.currentUser!.uid,
                      //                     'email': _auth.currentUser!.email,
                      //                     'tag': prov.createStateText
                      //                   });
                      //                 } on FirebaseException catch (e) {
                      //                   if (Platform.isAndroid) {
                      //                     switch (e.message) {
                      //                       default:
                      //                         print(
                      //                             'Case ${e.message} is not yet implemented');
                      //                     }
                      //                   } else if (Platform.isIOS) {}
                      //                 } finally {
                      //                   setState(() {
                      //                     _postController.clear();
                      //                     Navigator.pop(context);
                      //                     uploading = false;
                      //                   });
                      //                 }
                      //               }
                      //             },
                      //       child: const Text('Submit'))
                      // ]
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _postController,
                              //  decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   borderRadius: BorderRadius.circular(25),
                              //   border: Border.all(
                              //       color: Colors.black.withAlpha(40),
                              //       width: 2)),
                              decoration: textDecorated(
                                context,
                                hint: 'Please Ask or Share your case ... ',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20.0),
                              ),
                              minLines: 4,
                              maxLines: 8,
                              validator: (value) => value!.isEmpty ||
                                      value.characters.length > 800 ||
                                      prov.createStateText == null
                                  ? "Enter your case less than 800 characters and your field"
                                  : null,
                            ),
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Divider(
                          //     height: 1,
                          //     thickness: 1,
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'tag :',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black.withAlpha(40),
                                        width: 2)),
                                child: DropText(
                                  state: prov.createStateText,
                                  hint: 'Please select field',
                                  map: prov.createStateList.map((stateText) {
                                    return DropdownMenuItem(
                                        value: stateText,
                                        child: Text(stateText));
                                  }).toList(),
                                  onchange: (val) => prov.createClick(val),
                                  onSaved: (val) => prov.createClick(val),
                                ),
                              ),
                            ],
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Divider(
                          //     height: 1,
                          //     thickness: 1,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.black.withAlpha(40),
                                      width: 2)),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5),
                                  itemCount: _imageList.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return index == 0
                                        ? Column(
                                            children: [
                                              Center(
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    selectImage();
                                                  },
                                                ),
                                              ),
                                              const Text('Add photo')
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.file(
                                                  File(_imageList[index - 1]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                ),
                                                Container(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 244, 0.7),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      _imageList
                                                          .removeAt(index - 1);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ));
                                  }),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: uploading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        await CaseService().addCase(
                                          content: _postController.text,
                                          tag: prov.createStateText,
                                          uid: prov.uid!,
                                        );
                                      } catch (e) {
                                        print(e.toString());
                                      } finally {
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  },
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      // uploading
                      //     ? Center(
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             const Text('Uploading...'),
                      //             CircularProgressIndicator(
                      //               value: val,
                      //               valueColor:
                      //                   const AlwaysStoppedAnimation<Color>(
                      //                       Colors.green),
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //     : Container()
                    ));
              },
            )));
  }

  void selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    try {
      setState(() {
        _imageList.add(File(pickedImage!.path));
      });
      if (pickedImage == null) retrieveLostData();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageList.add(File(response.file!.path));
      });
    }
  }

//   Future uploadFile() async {
//     var i = 1;
//     for (var img in _imageList) {
//       setState(() {
//         val = i / _imageList.length;
//       });
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('cases/${path.basename(img.path)}');
//       File compressedImage =
//           await CompressImage().compressImage(imageFile: img);
//       await ref!.putFile(compressedImage).whenComplete(() async => {
//             await ref!.getDownloadURL().then((value) {
//               _urlList.add(value);
//               i++;
//             })
//           });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     imgRef = FirebaseFirestore.instance.collection('cases');
//   }
}
