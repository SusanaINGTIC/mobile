import 'package:flutter/material.dart';

class SnackBarNotification extends StatelessWidget {
  String title;

  SnackBarNotification({required this.title});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
  }
}
