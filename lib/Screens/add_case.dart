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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _medController = TextEditingController();

  bool value = true;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
        child: Form(
            key: _formKey,
            child: Scaffold(
                appBar: appBar(
                  'add new case',
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextF(
                          _nameController,
                          "Enter your case name which is private !!",
                          labelText: 'Case name',
                          hint: 'Please insert your case name ... ',
                          short: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextF(_medController,
                            "Enter your case medical history  !!",
                            labelText: 'Medical history',
                            hint:
                                'Please insert your case medical history ... ',
                            short: true),
                        const SizedBox(
                          height: 10,
                        ),
                        TextF(
                          _postController,
                          "Enter your case less than 800 characters and your field",
                          labelText: 'Case description',
                          hint: 'Please document your case ... ',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54.withAlpha(80),
                                    width: 2)),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5),
                                itemCount: _imageList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
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
                                      : Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.file(
                                              File(_imageList[index - 1].path),
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
                                                icon: const Icon(Icons.delete),
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        );
                                }),
                          ),
                        ),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: DropText(
                                state: prov.createStateText,
                                hint: 'Please select field',
                                map: prov.createStateList.map((stateText) {
                                  return DropdownMenuItem(
                                      value: stateText, child: Text(stateText));
                                }).toList(),
                                onchange: (val) => prov.createClick(val),
                                onSaved: (val) => prov.createClick(val),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: value,
                                onChanged: (value2) {
                                  setState(() {
                                    value = value2!;
                                  });
                                }),
                            const Text('Share my case to puplic cases.')
                          ],
                        ),
                        OutlinedButton(
                          onPressed: uploading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await CaseService().addCase(
                                        caseName: _nameController.text,
                                        medicalHistory: _medController.text,
                                        public: value,
                                        desc: _postController.text,
                                        tag: prov.createStateText,
                                        uid: prov.uid!,
                                      );
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      throw Exception(e.toString());
                                    }
                                  }
                                },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
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
