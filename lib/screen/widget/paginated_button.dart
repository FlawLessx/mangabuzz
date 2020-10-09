import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class PaginatedButton extends StatelessWidget {
  final String text;
  final Function function;
  final IconData icons;

  PaginatedButton(
      {@required this.text, @required this.function, @required this.icons});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
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
              icons,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
