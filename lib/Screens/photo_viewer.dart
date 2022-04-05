import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({Key? key, required this.photourl}) : super(key: key);
  final String photourl;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(photourl),
    );
  }
}
