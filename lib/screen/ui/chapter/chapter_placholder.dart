import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../widget/circular_progress.dart';
import '../../widget/round_button.dart';

Widget chapterAppbarPlaceholder(BuildContext context) {
  return SafeArea(
    child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
              color: Colors.grey)
        ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: ScreenUtil().setHeight(110),
                width: ScreenUtil().setHeight(110),
                color: Colors.transparent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContentPlaceholder(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(400),
                  ),
                  ContentPlaceholder(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(250),
                  ),
                ],
              ),
              RoundButton(
                  icons: Icons.close,
                  iconColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  enableShadow: true,
                  onTap: () => Navigator.pop(context))
            ],
          ),
        )),
  );
}

Widget chapterBodyPlaceholder() {
  List count = [1, 2, 3, 4, 5];

  return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: count.length,
      itemBuilder: (context, index) {
        return CustomCircularProgressIndicator();
      });
}
