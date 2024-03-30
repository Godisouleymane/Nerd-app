import 'package:flutter/material.dart';

void showAlertDialog(
    BuildContext context, String title, String message, String textButton) {
  AlertDialog(
    title: Text(title),
    content: SingleChildScrollView(
      child: ListBody(
        children: [
          Text(message),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(textButton),
      )
    ],
  );
}
