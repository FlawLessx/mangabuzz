import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';
import 'package:mangabuzz/core/util/route_generator.dart';
import 'package:mangabuzz/screen/ui/chapter/chapter_dropdown.dart';
import 'package:mangabuzz/screen/widget/round_button.dart';

class ChapterAppbar extends StatefulWidget {
  final MangaDetail mangaDetail;
  final String chapterEndpoint;
  final int selectedIndex;
  final bool fromHome;
  ChapterAppbar(
      {@required this.mangaDetail,
      @required this.chapterEndpoint,
      @required this.selectedIndex,
      @required this.fromHome});

  @override
  _ChapterAppbarState createState() => _ChapterAppbarState();
}

class _ChapterAppbarState extends State<ChapterAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
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
                    Text(
                      widget.mangaDetail.chapterList[widget.selectedIndex]
                          .chapterName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontFamily: "Poppins-Bold"),
                    ),
                    ChapterDropdownButton(
                      mangaDetail: widget.mangaDetail,
                      chapterEndpoint: widget.mangaDetail
                          .chapterList[widget.selectedIndex].chapterEndpoint,
                      selectedIndex: widget.selectedIndex,
                      fromHome: widget.fromHome,
                    )
                  ],
                ),
                RoundButton(
                    icons: Icons.close,
                    iconColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    enableShadow: true,
                    onTap: () {
                      if (widget.fromHome == false) {
                        Navigator.popUntil(
                            context, ModalRoute.withName(mangaDetailRoute));
                      } else {
                        Navigator.popUntil(
                            context, ModalRoute.withName(baseRoute));
                      }
                    })
              ],
            ),
          )),
    );
  }
}
