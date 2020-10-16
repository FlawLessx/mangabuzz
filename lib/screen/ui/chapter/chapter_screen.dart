import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/bloc/history_bloc/history_bloc.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/core/util/route_generator.dart';
import 'package:mangabuzz/screen/ui/error/error_screen.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';
import 'package:mangabuzz/screen/widget/refresh_snackbar.dart';

import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../widget/round_button.dart';
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
  ChapterPageArguments(
      {@required this.chapterEndpoint,
      @required this.selectedIndex,
      @required this.mangaDetail,
      this.mangaEndpoint,
      @required this.fromHome,
      @required this.historyModel});
}

class ChapterPage extends StatefulWidget {
  final String chapterEndpoint;
  final int selectedIndex;
  final MangaDetail mangaDetail;
  final String mangaEndpoint;
  final bool fromHome;
  final HistoryModel historyModel;
  ChapterPage(
      {@required this.chapterEndpoint,
      @required this.selectedIndex,
      @required this.mangaDetail,
      this.mangaEndpoint,
      @required this.fromHome,
      @required this.historyModel});

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  ScrollController _scrollController;
  bool reachEnd;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.position.atEdge) {
            if (_scrollController.position.pixels != 0) reachEnd = true;
          } else {
            reachEnd = false;
          }
        });
      });

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
        totalChapter: mangaDetail.chapterList.length,
        selectedIndex: selectedIndex,
        chapterReached:
            _getCurrentValue(mangaDetail.chapterList, selectedIndex));

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

  _navigate(String chapterEndpoint, int selectedIndex, MangaDetail mangaDetail,
      bool fromHome) {
    BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
        chapterEndpoint: chapterEndpoint,
        selectedIndex: selectedIndex,
        mangaDetail: mangaDetail,
        historyModel: null,
        fromHome: fromHome));
    Navigator.pushReplacementNamed(
      context,
      chapterRoute,
    );
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
        Navigator.pop(context);
        BlocProvider.of<ChapterScreenBloc>(context)
            .add(InitialStateChapterScreen());
        return false;
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
              preferredSize: Size.fromHeight(ScreenUtil().setHeight(220))),
          body: BlocConsumer<ChapterScreenBloc, ChapterScreenState>(
            listener: (context, state) {
              if (state is ChapterScreenError) {
                Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                  _refresh();
                }));
              }
            },
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
                      physics: ScrollPhysics(),
                      children: [
                        InteractiveViewer(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.chapterImg.length,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: state.chapterImg[index].imageLink,
                                  placeholder: (context, url) => Container(
                                    child: Center(
                                      child: SizedBox(
                                          height: ScreenUtil().setWidth(60),
                                          width: ScreenUtil().setWidth(60),
                                          child:
                                              CustomCircularProgressIndicator()),
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                );
                              }),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(200),
                          child: Column(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: FAProgressBar(
                                  currentValue: _getCurrentValue(
                                      state.chapterList, state.selectedIndex),
                                  maxValue: state.chapterList.length,
                                  size: ScreenUtil().setHeight(20),
                                  backgroundColor: Color(0xFFE5E5E5),
                                  progressColor: Color(0xFF4be2c0),
                                  borderRadius: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                        visible: state.selectedIndex ==
                                                state.mangaDetail.chapterList
                                                    .length
                                            ? false
                                            : true,
                                        child: RoundButton(
                                            icons: Icons.arrow_back,
                                            iconColor:
                                                Theme.of(context).primaryColor,
                                            backgroundColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.2),
                                            enableShadow: false,
                                            onTap: () {
                                              _navigate(
                                                  state
                                                      .mangaDetail
                                                      .chapterList[
                                                          (state.selectedIndex +
                                                              1)]
                                                      .chapterEndpoint,
                                                  state.selectedIndex + 1,
                                                  state.mangaDetail,
                                                  state.fromHome);
                                            }),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${state.chapterList[state.selectedIndex].chapterName}",
                                            style: TextStyle(
                                                fontFamily: "Poppins-Medium",
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "${getTranslated(context, 'fromChapter')} ${state.chapterList.length} chapter",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                      Visibility(
                                        visible: state.selectedIndex == 0
                                            ? false
                                            : true,
                                        child: RoundButton(
                                            iconColor:
                                                Theme.of(context).primaryColor,
                                            backgroundColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.2),
                                            enableShadow: false,
                                            icons: Icons.arrow_forward,
                                            onTap: () {
                                              _navigate(
                                                  state
                                                      .mangaDetail
                                                      .chapterList[
                                                          (state.selectedIndex -
                                                              1)]
                                                      .chapterEndpoint,
                                                  state.selectedIndex - 1,
                                                  state.mangaDetail,
                                                  state.fromHome);
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is ChapterScreenError) {
                return RefreshIndicator(
                    onRefresh: () async {
                      _refresh();
                    },
                    child: ErrorPage());
              } else {
                return chapterBodyPlaceholder();
              }
            },
          )),
    );
  }
}
