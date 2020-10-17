import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../widget/manga_item/manga_item_placeholder.dart';

Widget buildPaginatedScreenPlaceholder(BuildContext context) {
  int count = 5;
  List rowLength = [2, 1, 2];

  return SafeArea(
    child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      children: [
        Text(
          "searchQuery".tr(),
          style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
        ),
        SizedBox(height: ScreenUtil().setWidth(20)),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: count,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: rowLength.map((e) => mangaItemPlaceHolder()).toList(),
              );
            }),
      ],
    ),
  );
}
