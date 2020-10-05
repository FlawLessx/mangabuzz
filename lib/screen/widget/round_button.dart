import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  final IconData icons;
  final Function onTap;
  final Color backgroundColor;
  final Color iconColor;
  final bool enableShadow;
  RoundButton(
      {@required this.icons,
      @required this.onTap,
      @required this.backgroundColor,
      @required this.iconColor,
      @required this.enableShadow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenUtil().setHeight(110),
        width: ScreenUtil().setHeight(110),
        decoration: BoxDecoration(
          boxShadow: [
            if (enableShadow == true)
              BoxShadow(
                color: backgroundColor.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
          ],
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Center(
          child: Icon(
            icons,
            color: iconColor,
            size: ScreenUtil().setHeight(80),
          ),
        ),
      ),
    );
  }
}
