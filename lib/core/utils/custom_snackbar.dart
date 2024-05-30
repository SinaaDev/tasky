import 'package:flutter/material.dart';

class CustomSnackBar {
  final String contentText;
  final Color backgroundColor;

  CustomSnackBar({
    required this.contentText,
    this.backgroundColor = Colors.blue, // Default background color
  });

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(contentText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.fixed, // Fixed position
        duration: Duration(seconds: 3), // Default duration
      ),
    );
  }
}
