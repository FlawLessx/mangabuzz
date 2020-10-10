import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class PaginatedButton extends StatelessWidget {
  final String text;
  final Function function;
  final IconData icons;
  final bool leftIcon;

  PaginatedButton(
      {@required this.text,
      @required this.function,
      @required this.icons,
      this.leftIcon = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  spreadRadius: 2,
                  offset: Offset(0, 1))
            ],
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(60)))),
        child: leftIcon == false
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(30),
                    vertical: ScreenUtil().setWidth(10)),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      width: ScreenUtil().setWidth(40),
                      child: Icon(
                        icons,
                        color: Colors.white,
                        size: ScreenUtil().setWidth(60),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    right: ScreenUtil().setWidth(30),
                    left: ScreenUtil().setWidth(10),
                    top: ScreenUtil().setWidth(10),
                    bottom: ScreenUtil().setWidth(10)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      width: ScreenUtil().setWidth(30),
                      child: Icon(
                        icons,
                        color: Colors.white,
                        size: ScreenUtil().setWidth(60),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
