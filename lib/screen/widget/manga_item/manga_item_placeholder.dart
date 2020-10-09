import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

Widget mangaItemPlaceHolder() {
  return ContentPlaceholder(
    width: ScreenUtil().setWidth(300),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContentPlaceholder.block(
          width: ScreenUtil().setWidth(220),
          height: ScreenUtil().setWidth(320),
        ),
        ContentPlaceholder.block(
            width: ScreenUtil().setWidth(220),
            height: ScreenUtil().setHeight(60),
            bottomSpacing: ScreenUtil().setHeight(10)),
        ContentPlaceholder.block(
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(60),
            bottomSpacing: ScreenUtil().setHeight(10)),
        ContentPlaceholder.block(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setHeight(60),
        ),
      ],
    ),
  );
}
