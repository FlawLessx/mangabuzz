import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  final IconData icons;
  final Function onTap;
  RoundButton({@required this.icons, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenUtil().setHeight(110),
        width: ScreenUtil().setHeight(110),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Icon(
            icons,
            color: Colors.white,
            size: ScreenUtil().setHeight(80),
          ),
        ),
      ),
    );
  }
}
