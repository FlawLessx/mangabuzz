import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../core/util/route_generator.dart';
import 'bloc/chapter_screen_bloc.dart';
import 'chapter_screen.dart';

class ChapterDropdownButton extends StatefulWidget {
  final MangaDetail mangaDetail;
  final String chapterEndpoint;
  final int selectedIndex;
  final bool fromHome;
  ChapterDropdownButton({
    @required this.mangaDetail,
    @required this.selectedIndex,
    @required this.chapterEndpoint,
    @required this.fromHome,
  });

  @override
  _ChapterDropdownButtonState createState() => _ChapterDropdownButtonState();
}

class _ChapterDropdownButtonState extends State<ChapterDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            child: ChapterDropdownMenu(
              mangaDetail: widget.mangaDetail,
              selectedIndex: widget.selectedIndex,
              chapterEndpoint: widget.chapterEndpoint,
              fromHome: widget.fromHome,
            ));
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
            border: Border.all(color: Colors.black54)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: Text(
                  widget.mangaDetail.chapterList[widget.selectedIndex]
                      .chapterName,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: ScreenUtil().setWidth(70),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChapterDropdownMenu extends StatefulWidget {
  final MangaDetail mangaDetail;
  final String chapterEndpoint;
  final int selectedIndex;
  final bool fromHome;
  ChapterDropdownMenu({
    @required this.mangaDetail,
    @required this.selectedIndex,
    @required this.chapterEndpoint,
    @required this.fromHome,
  });

  @override
  _ChapterDropdownMenuState createState() => _ChapterDropdownMenuState();
}

class _ChapterDropdownMenuState extends State<ChapterDropdownMenu> {
  int selectedIndex;
  final double itemSize = 40;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    setState(() {
      selectedIndex = widget.selectedIndex;
    });
    super.initState();
  }

  _scrollToSelectedItem(int index) {
    _scrollController.jumpTo(0 + (itemSize * index));
  }

  _navigate(int index) {
    BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
        chapterEndpoint: widget.mangaDetail.chapterList[index].chapterEndpoint,
        selectedIndex: index,
        mangaDetail: widget.mangaDetail,
        historyModel: null,
        fromHome: widget.fromHome));
    Navigator.pushReplacementNamed(context, chapterRoute,
        arguments: ChapterPageArguments(
            chapterEndpoint:
                widget.mangaDetail.chapterList[index].chapterEndpoint,
            selectedIndex: index,
            mangaDetail: widget.mangaDetail,
            historyModel: null,
            fromHome: widget.fromHome));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _scrollToSelectedItem(selectedIndex));

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(40))),
      child: Container(
          height: ScreenUtil().setHeight(1200),
          width: ScreenUtil().setWidth(800),
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(60)),
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)),
                child: Text(
                  'selectChapter'.tr(),
                  style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: widget.mangaDetail.chapterList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: itemSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              _navigate(index);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(60)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.mangaDetail.chapterList[index]
                                        .chapterName,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Container(
                                    height: ScreenUtil().setWidth(40),
                                    width: ScreenUtil().setWidth(40),
                                    child: Radio(
                                        autofocus: selectedIndex == index
                                            ? true
                                            : false,
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: widget
                                            .mangaDetail.chapterList[index],
                                        groupValue: widget.mangaDetail
                                            .chapterList[selectedIndex],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedIndex = index;
                                          });

                                          _navigate(index);
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}
