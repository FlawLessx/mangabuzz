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
                height: ScreenUtil().setHeight(210),
                width: ScreenUtil().setHeight(110),
                color: Colors.transparent,
              ),
              Flexible(
                child: ContentPlaceholder(
                  spacing: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContentPlaceholder.block(
                        topSpacing: ScreenUtil().setHeight(20),
                        height: ScreenUtil().setHeight(40),
                        width: ScreenUtil().setWidth(500),
                      ),
                      ContentPlaceholder.block(
                        height: ScreenUtil().setHeight(40),
                        width: ScreenUtil().setWidth(500),
                      ),
                    ],
                  ),
                ),
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
  int count = 10;

  return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder: (context, index) {
        return Center(child: CustomCircularProgressIndicator());
      });
}
