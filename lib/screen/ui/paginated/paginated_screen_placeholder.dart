import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/screen/widget/manga_item/manga_item_placeholder.dart';

Widget buildPaginatedScreenPlaceholder() {
  List count = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  return ListView(
    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
    children: [
      Text(
        "Results for genre ",
        style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
      ),
      GridView.builder(
          itemCount: count.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: ScreenUtil().setWidth(20),
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            return mangaItemPlaceHolder();
          }),
    ],
  );
}
