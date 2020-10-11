import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/widget/round_button.dart';

class SearchBar extends PreferredSize {
  final String text;
  final Function function;
  final Function drawerFunction;
  SearchBar(
      {@required this.text,
      @required this.function,
      @required this.drawerFunction});

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(180));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(30),
            horizontal: ScreenUtil().setWidth(20)),
        child: Container(
          color: Colors.transparent,
          height: ScreenUtil().setHeight(150),
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                  child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFf3f4f6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(60)))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(30)),
                  child: TextField(
                      onTap: function,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: text,
                        hintStyle:
                            TextStyle(color: Color(0xFFb8bbc4), fontSize: 16),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFb8bbc4),
                          size: ScreenUtil().setHeight(80),
                        ),
                        enabled: true,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(30),
                            top: ScreenUtil().setHeight(30)),
                      )),
                ),
              )),
              SizedBox(width: ScreenUtil().setWidth(60)),
              RoundButton(
                  iconColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  enableShadow: true,
                  icons: Icons.menu,
                  onTap: drawerFunction)
            ],
          ),
        ),
      ),
    );
  }
}
