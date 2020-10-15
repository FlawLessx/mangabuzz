import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';
import 'package:mangabuzz/core/util/route_generator.dart';
import 'package:mangabuzz/screen/ui/chapter/bloc/chapter_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/chapter/chapter_screen.dart';

class MangaDetailNavbar extends StatelessWidget {
  final HistoryModel historyModel;
  final MangaDetail mangaDetail;

  MangaDetailNavbar({
    @required this.historyModel,
    @required this.mangaDetail,
  });

  _readFunction(HistoryModel historyModel, MangaDetail mangaDetail,
      BuildContext context) {
    if (historyModel == null) {
      BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
          chapterEndpoint: mangaDetail
              .chapterList[mangaDetail.chapterList.length - 1].chapterEndpoint,
          selectedIndex: (mangaDetail.chapterList.length - 1),
          mangaDetail: mangaDetail,
          historyModel: historyModel,
          fromHome: false));
      Navigator.pushNamed(context, chapterRoute,
          arguments: ChapterPageArguments(
              chapterEndpoint: mangaDetail
                  .chapterList[mangaDetail.chapterList.length - 1]
                  .chapterEndpoint,
              selectedIndex: (mangaDetail.chapterList.length - 1),
              historyModel: historyModel,
              mangaDetail: mangaDetail,
              fromHome: false));
    } else {
      BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
          chapterEndpoint: mangaDetail
              .chapterList[historyModel.selectedIndex].chapterEndpoint,
          selectedIndex: historyModel.selectedIndex,
          mangaDetail: mangaDetail,
          historyModel: historyModel,
          fromHome: false));
      Navigator.pushNamed(context, chapterRoute,
          arguments: ChapterPageArguments(
              chapterEndpoint: mangaDetail
                  .chapterList[historyModel.selectedIndex].chapterEndpoint,
              selectedIndex: historyModel.selectedIndex,
              mangaDetail: mangaDetail,
              historyModel: historyModel,
              fromHome: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(150),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 2,
              spreadRadius: 4,
              offset: Offset(2, 0))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            historyModel != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${historyModel.chapterReached} ${getTranslated(context, 'chapterReached')}",
                          style: TextStyle(
                              fontSize: 13, fontFamily: "Poppins-Medium")),
                      Text(
                        "${mangaDetail.chapterList.length - historyModel.chapterReached} ${getTranslated(context, 'chapterRemains')}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  )
                : SizedBox(),
            InkWell(
              onTap: () {
                _readFunction(historyModel, mangaDetail, context);
              },
              child: Chip(
                label: historyModel != null
                    ? Text(getTranslated(context, "continueRead"))
                    : Text(getTranslated(context, "startRead")),
                labelStyle:
                    TextStyle(color: Colors.white, fontFamily: "Poppins-Bold"),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 4.0,
                shadowColor: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
            )
          ],
        ));
  }
}
