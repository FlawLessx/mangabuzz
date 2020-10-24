import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';

import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../core/util/route_generator.dart';
import '../../widget/round_button.dart';
import '../history/bloc/history_screen_bloc.dart';
import 'chapter_dropdown.dart';

class ChapterAppbar extends StatefulWidget {
  final MangaDetail mangaDetail;
  final String chapterEndpoint;
  final int selectedIndex;
  final bool fromHome;
  ChapterAppbar({
    @required this.mangaDetail,
    @required this.chapterEndpoint,
    @required this.selectedIndex,
    @required this.fromHome,
  });

  @override
  _ChapterAppbarState createState() => _ChapterAppbarState();
}

class _ChapterAppbarState extends State<ChapterAppbar> {
  @override
  void initState() {
    super.initState();
  }

  _navigate() {
    BlocProvider.of<HistoryScreenBloc>(context).add(GetHistoryScreenData());
    if (widget.fromHome == false) {
      BlocProvider.of<MangaDetailScreenBloc>(context).add(
          GetMangaDetailScreenData(
              mangaEndpoint: widget.mangaDetail.mangaEndpoint,
              title: widget.mangaDetail.title));
      Navigator.popUntil(context, ModalRoute.withName(mangaDetailRoute));
    } else {
      Navigator.popUntil(context, ModalRoute.withName(baseRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigate();
        return false;
      },
      child: SafeArea(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(110),
                    width: ScreenUtil().setHeight(110),
                    color: Colors.transparent,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.mangaDetail.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontFamily: "Poppins-Bold"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(150)),
                          child: ChapterDropdownButton(
                            mangaDetail: widget.mangaDetail,
                            chapterEndpoint: widget
                                .mangaDetail
                                .chapterList[widget.selectedIndex]
                                .chapterEndpoint,
                            selectedIndex: widget.selectedIndex,
                            fromHome: widget.fromHome,
                          ),
                        )
                      ],
                    ),
                  ),
                  RoundButton(
                      icons: Icons.close,
                      iconColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      enableShadow: true,
                      onTap: () {
                        _navigate();
                      })
                ],
              ),
            )),
      ),
    );
  }
}
