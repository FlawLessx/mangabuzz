import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';

class ChapterDropdownButton extends StatefulWidget {
  final List<ChapterList> chapterList;
  final int selectedIndex;
  ChapterDropdownButton(
      {@required this.chapterList, @required this.selectedIndex});

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
                chapterList: widget.chapterList,
                selectedIndex: widget.selectedIndex));
      },
      child: Container(
        width: ScreenUtil().setWidth(400),
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
                  widget.chapterList[widget.selectedIndex].chapterName,
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
  final List<ChapterList> chapterList;
  final int selectedIndex;
  ChapterDropdownMenu(
      {@required this.chapterList, @required this.selectedIndex});

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
                  "Select Chapter",
                  style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: widget.chapterList.length,
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
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(60)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.chapterList[index].chapterName,
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
                                        value: widget.chapterList[index],
                                        groupValue:
                                            widget.chapterList[selectedIndex],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedIndex = index;
                                          });
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
