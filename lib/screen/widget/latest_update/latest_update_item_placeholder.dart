import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLatestUpdatePlaceholder() {
  int count = 10;

  return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: count,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenUtil().setWidth(30),
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 0),
      itemBuilder: (context, index) {
        return ContentPlaceholder(
          child: Row(
            children: [
              ContentPlaceholder.block(
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setWidth(280),
                rightSpacing: ScreenUtil().setWidth(20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentPlaceholder.block(
                    width: ScreenUtil().setWidth(270),
                    height: ScreenUtil().setHeight(60),
                  ),
                  ContentPlaceholder.block(
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setHeight(40),
                  ),
                  ContentPlaceholder.block(
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setHeight(40),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
