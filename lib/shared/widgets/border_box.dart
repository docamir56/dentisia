import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  // final double height, width;

  const BorderBox(
      {Key? key,
      this.padding,
      // required this.height,
      // required this.width,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blue.withAlpha(50), width: 2)),
      padding: padding ?? const EdgeInsets.all(8),
      child: Center(child: child),
    );
  }
}
