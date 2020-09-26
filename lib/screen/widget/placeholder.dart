import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'manga_item.dart';

Widget bestSeriesPlaceholder() {
  return ContentPlaceholder(
    height: ScreenUtil().setHeight(370),
    width: double.infinity,
  );
}

Widget buildHotSeriesUpdatePlaceholder() {
  List count = [1, 2, 3, 4];

  return SingleChildScrollView(
    padding: EdgeInsets.zero,
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: count
          .map((item) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setHeight(20)),
                child: mangaItemPlaceHolder(),
              ))
          .toList(),
    ),
  );
}

Widget buildLatestUpdatePlaceholder() {
  List count = [1, 2, 3, 4];

  return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: count.length,
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

Widget buildBookmarkPlaceholder() {
  List count = [1, 2, 3];

  return SingleChildScrollView(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  );
}
