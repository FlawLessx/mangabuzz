import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/ui/history/bloc/history_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';

import '../../../core/bloc/history_bloc/history_bloc.dart';
import '../../../core/model/history/history_model.dart';
import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../core/util/route_generator.dart';
import '../../widget/circular_progress.dart';
import '../../widget/round_button.dart';
import '../error/error_screen.dart';
import 'bloc/chapter_screen_bloc.dart';
import 'chapter_appbar.dart';
import 'chapter_placholder.dart';

class ChapterPageArguments {
  final String chapterEndpoint;
  final int selectedIndex;
  final MangaDetail mangaDetail;
  final String mangaEndpoint;
  final bool fromHome;
  final HistoryModel historyModel;
  ChapterPageArguments({
    @required this.chapterEndpoint,
    @required this.selectedIndex,
    @required this.mangaDetail,
    this.mangaEndpoint,
    @required this.fromHome,
    @required this.historyModel,
  });
}

class ChapterPage extends StatefulWidget {
  final String chapterEndpoint;
  final int selectedIndex;
  final MangaDetail mangaDetail;
  final String mangaEndpoint;
  final bool fromHome;
  final HistoryModel historyModel;
  ChapterPage({
    @required this.chapterEndpoint,
    @required this.selectedIndex,
    @required this.mangaDetail,
    this.mangaEndpoint,
    @required this.fromHome,
    @required this.historyModel,
  });

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  _addToHistory(MangaDetail mangaDetail, int selectedIndex) {
    final model = HistoryModel(
        author: mangaDetail.author,
        image: mangaDetail.image,
        mangaEndpoint: mangaDetail.mangaEndpoint,
        rating: mangaDetail.rating,
        title: mangaDetail.title,
        type: mangaDetail.type,
        totalChapter: _chapterConvert(mangaDetail, 0),
        selectedIndex: selectedIndex,
        chapterReached: _chapterConvert(mangaDetail, selectedIndex),
        chapterReachedName:
            mangaDetail.chapterList[selectedIndex].chapterName.split(' ')[1]);

    BlocProvider.of<HistoryBloc>(context).add(AddHistory(historyModel: model));
  }

  int _getCurrentValue(List<ChapterList> oldList, int selectedIndex) {
    List<ChapterList> newList = oldList.reversed.toList();
    var data = oldList[selectedIndex].chapterName;
    int index = 0;

    for (int i = 0; i < newList.length; i++) {
      if (data != newList[i].chapterName)
        index++;
      else {
        index++;
        break;
      }
    }

    return index;
  }

  int _chapterConvert(MangaDetail mangaDetail, int selectedIndex) {
    int result;
    if (mangaDetail.chapterList[selectedIndex].chapterName
        .split(' ')[1]
        .contains('.')) {
      result = int.parse(mangaDetail.chapterList[selectedIndex].chapterName
          .split(' ')[1]
          .split('.')[0]);
    } else {
      result = int.parse(
          mangaDetail.chapterList[selectedIndex].chapterName.split(' ')[1]);
    }

    return result.floor();
  }

  _navigate(String chapterEndpoint, int selectedIndex, MangaDetail mangaDetail,
      bool fromHome) {
    BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
        chapterEndpoint: chapterEndpoint,
        selectedIndex: selectedIndex,
        mangaDetail: mangaDetail,
        historyModel: null,
        fromHome: fromHome));
    Navigator.pushReplacementNamed(context, chapterRoute,
        arguments: ChapterPageArguments(
            chapterEndpoint: chapterEndpoint,
            selectedIndex: selectedIndex,
            mangaDetail: mangaDetail,
            historyModel: null,
            fromHome: fromHome));
  }

  _backNavigate() {
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

  _refresh() {
    BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
        chapterEndpoint: widget.chapterEndpoint,
        fromHome: widget.fromHome,
        mangaDetail: widget.mangaDetail,
        selectedIndex: widget.selectedIndex,
        historyModel: null,
        mangaEndpoint: widget.mangaEndpoint));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backNavigate();
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
              child: BlocBuilder<ChapterScreenBloc, ChapterScreenState>(
                builder: (context, state) {
                  if (state is ChapterScreenLoaded) {
                    return ChapterAppbar(
                      mangaDetail: state.mangaDetail,
                      chapterEndpoint: state.mangaDetail
                          .chapterList[state.selectedIndex].chapterEndpoint,
                      selectedIndex: state.selectedIndex,
                      fromHome: state.fromHome,
                    );
                  } else {
                    return chapterAppbarPlaceholder(context);
                  }
                },
              ),
              preferredSize: Size.fromHeight(ScreenUtil().setHeight(170))),
          body: BlocConsumer<ChapterScreenBloc, ChapterScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ChapterScreenLoaded) {
                _addToHistory(state.mangaDetail, state.selectedIndex);

                return RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    BlocProvider.of<ChapterScreenBloc>(context).add(
                        GetChapterScreenData(
                            chapterEndpoint: state
                                .mangaDetail
                                .chapterList[state.selectedIndex]
                                .chapterEndpoint,
                            fromHome: state.fromHome,
                            mangaDetail: state.mangaDetail,
                            selectedIndex: state.selectedIndex,
                            historyModel: null,
                            mangaEndpoint: state.mangaDetail.mangaEndpoint));
                  },
                  child: DraggableScrollbar.semicircle(
                    controller: _scrollController,
                    child: ListView(
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        InteractiveViewer(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.chapterImg.length,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: state.chapterImg[index].imageLink,
                                  placeholder: (context, string) => Container(
                                    child: Center(
                                      child: SizedBox(
                                          height: ScreenUtil().setWidth(80),
                                          width: ScreenUtil().setWidth(80),
                                          child:
                                              CustomCircularProgressIndicator()),
                                    ),
                                  ),
                                  errorWidget: (context, string, e) =>
                                      Icon(Icons.error),
                                );
                              }),
                        ),
                        bottomNavigation(state.selectedIndex, state.mangaDetail,
                            state.fromHome)
                      ],
                    ),
                  ),
                );
              } else if (state is ChapterScreenError) {
                return ErrorPage(callback: _refresh());
              } else {
                return chapterBodyPlaceholder();
              }
            },
          )),
    );
  }

  Widget bottomNavigation(
      int selectedIndex, MangaDetail mangaDetail, bool fromHome) {
    return Container(
      height: ScreenUtil().setHeight(200),
      child: Column(
        children: [
          Transform.scale(
            scale: 1.1,
            child: FAProgressBar(
              currentValue:
                  _getCurrentValue(mangaDetail.chapterList, selectedIndex),
              maxValue: mangaDetail.chapterList.length,
              size: ScreenUtil().setHeight(20),
              backgroundColor: Color(0xFFE5E5E5),
              progressColor: Color(0xFF4be2c0),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  selectedIndex == mangaDetail.chapterList.length - 1
                      ? SizedBox(
                          width: ScreenUtil().setHeight(120),
                        )
                      : RoundButton(
                          icons: Icons.arrow_back,
                          iconColor: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          enableShadow: false,
                          onTap: () {
                            _navigate(
                                mangaDetail.chapterList[(selectedIndex + 1)]
                                    .chapterEndpoint,
                                selectedIndex + 1,
                                mangaDetail,
                                fromHome);
                          }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${mangaDetail.chapterList[selectedIndex].chapterName}",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium", fontSize: 14),
                      ),
                      Text(
                        "${'fromChapter'.tr()} ${mangaDetail.chapterList[0].chapterName.split(' ')[1]} chapter",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                  selectedIndex == 0
                      ? SizedBox(
                          width: ScreenUtil().setHeight(120),
                        )
                      : RoundButton(
                          iconColor: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          enableShadow: false,
                          icons: Icons.arrow_forward,
                          onTap: () {
                            _navigate(
                                mangaDetail.chapterList[(selectedIndex - 1)]
                                    .chapterEndpoint,
                                selectedIndex - 1,
                                mangaDetail,
                                fromHome);
                          }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
