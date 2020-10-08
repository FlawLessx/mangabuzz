import 'dart:ui';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/util/route_generator.dart';

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
  ChapterPageArguments(
      {@required this.chapterEndpoint,
      @required this.selectedIndex,
      @required this.mangaDetail,
      this.mangaEndpoint});
}

class ChapterPage extends StatefulWidget {
  final String chapterEndpoint;
  final int selectedIndex;
  final MangaDetail mangaDetail;
  final String mangaEndpoint;
  ChapterPage(
      {@required this.chapterEndpoint,
      @required this.selectedIndex,
      @required this.mangaDetail,
      this.mangaEndpoint});

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
    BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
        chapterEndpoint: widget.chapterEndpoint,
        selectedIndex: widget.selectedIndex,
        mangaDetail: widget.mangaDetail,
        mangaEndpoint: widget.mangaEndpoint));
    super.initState();
  }

  int _getCurrentValue(List<ChapterList> oldList, int selectedIndex) {
    List<ChapterList> newList = oldList.reversed.toList();
    var data = oldList[selectedIndex].chapterName;
    int index = 0;

    for (int i = 0; i < newList.length; i++) {
      if (data != newList[i].chapterName)
        index++;
      else
        break;
    }

    return index;
  }

  _navigate(
      String chapterEndpoint, int selectedIndex, MangaDetail mangaDetail) {
    Navigator.pushReplacementNamed(context, chapterRoute,
        arguments: ChapterPageArguments(
          chapterEndpoint: chapterEndpoint,
          selectedIndex: selectedIndex,
          mangaDetail: mangaDetail,
        ));
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
                      mangaDetail: widget.mangaDetail,
                      chapterEndpoint: state.mangaDetail
                          .chapterList[state.selectedIndex].chapterEndpoint,
                      selectedIndex: state.selectedIndex,
                    );
                  } else {
                    return chapterAppbarPlaceholder(context);
                  }
                },
              ),
              preferredSize: Size.fromHeight(ScreenUtil().setHeight(220))),
          body: BlocBuilder<ChapterScreenBloc, ChapterScreenState>(
            builder: (context, state) {
              if (state is ChapterScreenLoaded) {
                return DraggableScrollbar.semicircle(
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
                              return Image(
                                  filterQuality: FilterQuality.high,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error_outline);
                                  },
                                  image: AdvancedNetworkImage(
                                      state.chapterImg[index].imageLink,
                                      retryLimit: 5,
                                      timeoutDuration: Duration(seconds: 60),
                                      printError: true,
                                      disableMemoryCache: true,
                                      fallbackAssetImage:
                                          "resources/img/error.png"));
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
                                                state.mangaDetail);
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
                                          "From ${state.chapterList.length} chapter",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                    Visibility(
                                      visible: widget.selectedIndex == 0
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
                                                state.mangaDetail);
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
                );
              } else {
                return chapterBodyPlaceholder();
              }
            },
          )),
    );
  }
}
