import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/model/manga_detail/manga_detail_model.dart';

class ChapterItem extends StatefulWidget {
  final ChapterList chapterListData;
  ChapterItem({@required this.chapterListData});

  @override
  _ChapterItemState createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(90),
      width: ScreenUtil().setWidth(500),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.10),
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setHeight(50)))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(40),
            vertical: ScreenUtil().setHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.chapterListData.chapterName,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 14)),
            Text(widget.chapterListData.updatedOn,
                style: TextStyle(color: Color(0xFFb8bbc4), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
