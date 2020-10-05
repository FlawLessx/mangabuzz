import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/widget/round_button.dart';

class SearchBar extends PreferredSize {
  final String text;
  final Function function;
  SearchBar({@required this.text, @required this.function});

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(200));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
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
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Search something...",
                        hintStyle:
                            TextStyle(color: Color(0xFFb8bbc4), fontSize: 18),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFb8bbc4),
                          size: ScreenUtil().setHeight(80),
                        ),
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
                  onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
