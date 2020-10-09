import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/widget/manga_item/manga_item_placeholder.dart';

Widget buildExploreScreenPlaceholder() {
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Genres",
              style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
            ),
            ContentPlaceholder(
              height: ScreenUtil().setHeight(120),
              width: double.infinity,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Text(
              "List Manga",
              style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
            ),
            listItemPlaceholder(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Text(
              "List Manhwa",
              style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
            ),
            listItemPlaceholder(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Text(
              "List Manhua",
              style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
            ),
            listItemPlaceholder()
          ],
        ),
      ),
    ],
  );
}

Widget listItemPlaceholder() {
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
