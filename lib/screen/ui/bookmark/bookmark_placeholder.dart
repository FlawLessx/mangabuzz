import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBookmarkScreenPlaceholder() {
  List count = [1, 2, 3];

  return ListView(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
    children: [
      Text(
        "Bookmarked Series",
        style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(20),
      ),
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: count
              .map((e) => ContentPlaceholder(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ContentPlaceholder.block(
                            width: ScreenUtil().setWidth(220),
                            height: ScreenUtil().setWidth(320),
                            rightSpacing: ScreenUtil().setWidth(15)),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContentPlaceholder.block(
                                  width: double.infinity,
                                  height: ScreenUtil().setHeight(60),
                                  bottomSpacing: ScreenUtil().setHeight(10)),
                              ContentPlaceholder.block(
                                  width: ScreenUtil().setWidth(350),
                                  height: ScreenUtil().setHeight(60),
                                  bottomSpacing: ScreenUtil().setHeight(10)),
                              ContentPlaceholder.block(
                                  width: double.infinity,
                                  height: ScreenUtil().setHeight(100),
                                  bottomSpacing: ScreenUtil().setHeight(10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ContentPlaceholder.block(
                                    width: ScreenUtil().setWidth(300),
                                    height: ScreenUtil().setHeight(50),
                                  ),
                                  ContentPlaceholder.block(
                                    width: ScreenUtil().setWidth(250),
                                    height: ScreenUtil().setHeight(70),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    ],
  );
}
