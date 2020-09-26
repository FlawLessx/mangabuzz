import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class PaginatedButton extends StatelessWidget {
  final String text;
  final Function function;

  PaginatedButton({@required this.text, @required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFf3f4f6),
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(60)))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setHeight(30),
            vertical: ScreenUtil().setHeight(15)),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
