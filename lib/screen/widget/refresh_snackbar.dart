import 'package:flutter/material.dart';

Widget refreshSnackBar(Function function) {
  return SnackBar(
    content: Text('Please check your internet connection, try again?'),
    action: SnackBarAction(label: 'Refresh', onPressed: function),
  );
}
