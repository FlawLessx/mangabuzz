import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      chapterList: state.chapterList,
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
                                  image: AdvancedNetworkImage(
                                      state.chapterImg[index].imageLink,
                                      retryLimit: 5,
                                      timeoutDuration: Duration(seconds: 60),
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
                                    RoundButton(
                                        icons: Icons.arrow_back,
                                        iconColor:
                                            Theme.of(context).primaryColor,
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.2),
                                        enableShadow: false,
                                        onTap: () {}),
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
                                    RoundButton(
                                        iconColor:
                                            Theme.of(context).primaryColor,
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.2),
                                        enableShadow: false,
                                        icons: Icons.arrow_forward,
                                        onTap: () {}),
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
