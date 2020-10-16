import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          "resources/img/error.png",
          width: ScreenUtil().setWidth(600),
          height: ScreenUtil().setWidth(600),
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
