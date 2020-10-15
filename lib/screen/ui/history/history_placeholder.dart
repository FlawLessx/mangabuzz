import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';

Widget buildHistoryScreenPlaceholder(BuildContext context) {
  List count = [1, 2, 3, 4];

  return ListView(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
    children: [
      Text(
        getTranslated(context, 'readHistory'),
        style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
      ),
      ListView.builder(
          itemCount: count.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ContentPlaceholder(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ContentPlaceholder.block(
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setWidth(350),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContentPlaceholder.block(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(60),
                            bottomSpacing: ScreenUtil().setHeight(10)),
                        ContentPlaceholder.block(
                          width: ScreenUtil().setWidth(400),
                          height: ScreenUtil().setHeight(40),
                          bottomSpacing: ScreenUtil().setHeight(10),
                        ),
                        ContentPlaceholder.block(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(40),
                            bottomSpacing: ScreenUtil().setHeight(10)),
                        ContentPlaceholder.block(
                            width: ScreenUtil().setWidth(200),
                            height: ScreenUtil().setHeight(40)),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    ],
  );
}
