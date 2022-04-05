import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MultiPhotoViewer extends StatefulWidget {
  const MultiPhotoViewer({Key? key, required this.galleryItems})
      : super(key: key);
  final List galleryItems;
  @override
  _MultiPhotoViewerState createState() => _MultiPhotoViewerState();
}

class _MultiPhotoViewerState extends State<MultiPhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(widget.galleryItems[index]),
          initialScale: PhotoViewComputedScale.contained,
          heroAttributes:
              PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
        );
      },
      itemCount: widget.galleryItems.length,
      loadingBuilder: (context, ImageChunkEvent? event) => const Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
              // value: event == null
              //     ? 0.0
              //     : event.cumulativeBytesLoaded /
              //         event.expectedTotalBytes!.toDouble(),
              ),
        ),
      ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    );
  }
}
