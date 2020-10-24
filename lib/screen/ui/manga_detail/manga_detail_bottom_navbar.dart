import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../core/model/history/history_model.dart';
import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../core/util/route_generator.dart';
import '../chapter/bloc/chapter_screen_bloc.dart';
import '../chapter/chapter_screen.dart';

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
                ? Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "${historyModel.chapterReachedName} ${'chapterReached'.tr()}",
                          style: TextStyle(
                              fontSize: 13, fontFamily: "Poppins-Medium"),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          maxFontSize: 13,
                          minFontSize: 11,
                        ),
                        AutoSizeText(
                          "${historyModel.totalChapter - historyModel.chapterReached} ${'chapterRemains'.tr()}",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 11,
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            InkWell(
              onTap: () {
                _readFunction(historyModel, mangaDetail, context);
              },
              child: Chip(
                label: historyModel != null
                    ? Text("continueRead".tr())
                    : Text("startRead".tr()),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins-Bold",
                    fontSize: 16),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 4.0,
                shadowColor: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
            )
          ],
        ));
  }
}
