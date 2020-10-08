import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor:
          new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );
  }
}
