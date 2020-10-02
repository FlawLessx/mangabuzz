import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/widget/placeholder.dart';
import 'package:mangabuzz/screen/widget/round_button.dart';

Widget buildMangaDetailPagePlaceholder(BuildContext context) {
  List count = [1, 2, 3, 4, 5];

  return ListView(
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
        vertical: ScreenUtil().setWidth(30)),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundButton(
              icons: Icons.arrow_back, onTap: () => Navigator.pop(context)),
          GestureDetector(
            child: Icon(
              Icons.favorite,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setHeight(80),
            ),
          )
        ],
      ),
      SizedBox(
        height: ScreenUtil().setHeight(20),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mangaItemPlaceHolder(),
          ContentPlaceholder(
              height: ScreenUtil().setHeight(300),
              width: ScreenUtil().setWidth(1000)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "List Chapter",
                  style: TextStyle(
                      fontFamily: "Poppins-Bold",
                      fontSize: 16,
                      color: Colors.black),
                ),
                Text(
                  "Download",
                  style: TextStyle(
                      fontFamily: "Poppins-Bold",
                      fontSize: 16,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: count.length,
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(100)),
              itemBuilder: (context, index) {
                return ContentPlaceholder(
                  spacing: EdgeInsets.zero,
                  height: ScreenUtil().setHeight(70),
                );
              })
        ],
      )
    ],
  );
}

Widget buildBottomNavigationPlaceholder() {
  return ContentPlaceholder(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContentPlaceholder.block(
          topSpacing: ScreenUtil().setHeight(30),
          bottomSpacing: ScreenUtil().setHeight(10),
          leftSpacing: ScreenUtil().setWidth(40),
          height: ScreenUtil().setHeight(100),
          width: ScreenUtil().setWidth(500),
        ),
        ContentPlaceholder.block(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(350),
          topSpacing: ScreenUtil().setHeight(30),
          bottomSpacing: ScreenUtil().setHeight(10),
          rightSpacing: ScreenUtil().setWidth(40),
        )
      ],
    ),
  );
}
