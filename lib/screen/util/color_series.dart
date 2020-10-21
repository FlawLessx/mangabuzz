import 'package:flutter/material.dart';

class ColorSeries {
  Color generateColor(String type) {
    if (type == "Manga")
      return Color(0xFFa78df7);
    else if (type == "Manhua")
      return Color(0xFFDD392E);
    else
      return Color(0xFFF39800);
  }
}
