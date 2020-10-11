import 'package:flutter/material.dart';

class DrawerItem {
  final String text;
  final Function function;
  final IconData icons;
  final int selectedIndex;

  DrawerItem(
      {@required this.text,
      @required this.function,
      @required this.icons,
      @required this.selectedIndex});
}
