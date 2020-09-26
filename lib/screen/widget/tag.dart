import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/util/color_series.dart';

class Tag extends StatelessWidget {
  final bool isHot;
  Tag({@required this.isHot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      child: Container(
        height: ScreenUtil().setWidth(70),
        width: ScreenUtil().setWidth(70),
        decoration: BoxDecoration(
            color: isHot == true ? Color(0xFFDD392E) : Color(0xFFF39800),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))),
        child: Center(
          child: Text(
            isHot == true ? "H" : "N",
            style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold"),
          ),
        ),
      ),
    );
  }
}

class TypeTag extends StatelessWidget {
  final String type;
  final double fontSize;
  TypeTag({@required this.type, @required this.fontSize});

  @override
  Widget build(BuildContext context) {
    ColorSeries colorSeries = ColorSeries();

    return Container(
      height: ScreenUtil().setHeight(70),
      decoration: BoxDecoration(
          color: colorSeries.generateColor(type),
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
          child: Text(
            type,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontFamily: 'Poppins-Semibold'),
          ),
        ),
      ),
    );
  }
}
