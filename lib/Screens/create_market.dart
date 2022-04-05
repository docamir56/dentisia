import 'dart:io';

import 'package:dentisia/service/controller/market.dart';
import 'package:dentisia/shared/prov.dart';
import 'package:dentisia/shared/const.dart';
import 'package:dentisia/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateItem extends StatefulWidget {
  static const route = '/createItem';
  const CreateItem({Key? key}) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final TextEditingController _itemController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? _image;

  String? urlPhoto;
  bool uploading = false;
  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<Prov>(context, listen: false);
    return SafeArea(
      child: Form(
          key: _formKey,
          child: Scaffold(
              appBar: appBar('create new item'),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropText(
                        state: _prov.stateMarket,
                        hint: "State of item",
                        map: _prov.stateMarketList.map((_state) {
                          return DropdownMenuItem(
                              value: _state, child: Text(_state));
                        }).toList(),
                        onchange: (val) => _prov.onMarketChange(val),
                        onSaved: (val) => _prov.onMarketChange(val),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextF(
                        _itemController,
                        "Enter your item",
                        hint: 'Item',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextF(_descriptionController, "Enter description",
                          hint: 'Description'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextF(_priceController, "Enter price",
                          hint: 'Price', keybord: TextInputType.number),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextF(_phoneController, "Enter your phone",
                    //       hint: 'phone', keybord: TextInputType.phone),
                    // ),
                    _image == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
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
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    color: const Color.fromRGBO(
                                        255, 255, 244, 0.7),
                                    child: IconButton(
                                      onPressed: () {
                                        _image = null;
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            )),
                    uploading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Uploading...'),
                                CircularProgressIndicator()
                              ],
                            ),
                          )
                        : Container(),
                    OutlinedButton(
                        onPressed: uploading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    setState(() {
                                      uploading = true;
                                    });
                                    await MarketService().addMarket(
                                        jwt: _prov.token!,
                                        item: _itemController.text,
                                        desc: _descriptionController.text,
                                        price: _priceController.text,
                                        stat: _prov.stateMarket,
                                        uid: _prov.uid!);
                                  } finally {
                                    setState(() {
                                      _descriptionController.clear();
                                      _itemController.clear();
                                      _priceController.clear();
                                      Navigator.pop(context);
                                      uploading = false;
                                    });
                                  }
                                }
                              },
                        child: const Text(
                          'Share',
                        )),
                  ],
                ),
              ))),
    );
  }

  void selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    try {
      setState(() {
        _image = File(pickedImage!.path);
      });
      if (pickedImage == null) retrieveLostData(pickedImage);
    } catch (e) {
      e.toString();
    }
  }

  Future<void> retrieveLostData(pickedImage) async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(pickedImage!.path);
      });
    }
  }

  // Future uploadFile() async {
  //   ref = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('cases/${path.basename(_image!.path)}');
  //   File compressedImage =
  //       await CompressImage().compressImage(imageFile: _image);
  //   await ref!.putFile(compressedImage).whenComplete(() async => {
  //         await ref!.getDownloadURL().then((value) {
  //           urlPhoto = value;
  //         })
  //       });
  // }
}
