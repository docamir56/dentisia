import 'package:flutter/material.dart';

PreferredSizeWidget appBar(String title,
    {PreferredSizeWidget? bottom,
    List<Widget>? action,
    Widget? leading,
    bool? center = true}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    leading: leading,
    title: Text(
      title,
      style: const TextStyle(
        fontFamily: 'Pacifico',
        color: Colors.black87,
        letterSpacing: 1.0,
      ),
    ),
    centerTitle: center,
    bottom: bottom,
    actions: action,
    elevation: 0.0,
  );
}
