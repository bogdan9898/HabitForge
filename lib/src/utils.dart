import 'dart:convert';

import 'package:flutter/material.dart';

void displayErrorAlert(
  BuildContext context,
  error,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('An error ocurred'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            )
          ],
        );
      });
}

String utf8Str(String str) {
  return String.fromCharCodes(utf8.encode(str));
}

String unicodeStr(String str) {
  return utf8.decode(str.runes.toList());
}
