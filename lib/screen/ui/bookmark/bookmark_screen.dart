import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
import '../../widget/search/search_bar.dart';
import '../../widget/search/search_page.dart';
import '../error/error_screen.dart';
import 'bloc/bookmark_screen_bloc.dart';
import 'bookmark_item.dart';
import 'bookmark_placeholder.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  ScrollController _scrollController;
  List<BookmarkModel> originalData;
  List<BookmarkModel> data;
  int currentIndex = 0;
  static const ITEM_COUNT = 10;

  @override
  void initState() {
    super.initState();
    data = [];
    originalData = [];
    _refresh();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (currentIndex != originalData.length) {
            _loadMore();
          }
        }
      });
  }

  _refresh() {
    BlocProvider.of<BookmarkScreenBloc>(context).add(GetBookmarkScreenData());
  }

  Future _loadMore() async {
    if ((currentIndex + ITEM_COUNT) >= originalData.length) {
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          data.addAll(originalData.getRange(currentIndex, originalData.length));
          currentIndex = currentIndex + (originalData.length - currentIndex);
        });
      });
    } else {
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          data.addAll(
              originalData.getRange(currentIndex, currentIndex + ITEM_COUNT));
          currentIndex = currentIndex + ITEM_COUNT;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: SearchBar(
        text: "searchBookmark".tr(),
        function: () {
          showSearch(
              context: context,
              delegate: SearchWidget(
                  searchBloc: BlocProvider.of<SearchBloc>(context),
                  isFromAPI: false,
                  isBookmark: true,
                  isHistory: false));
        },
        drawerFunction: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: BlocConsumer<BookmarkScreenBloc, BookmarkScreenState>(
        listener: (context, state) {
          if (state is BookmarkScreenLoaded) {
            data = [];
            originalData = [];
            final length = state.listBookmarkData.length <= ITEM_COUNT
                ? state.listBookmarkData.length
                : ITEM_COUNT;
            setState(() {
              currentIndex = length;
              data.addAll(state.listBookmarkData.getRange(0, length));
              originalData = state.listBookmarkData;
            });
          }
        },
        builder: (context, state) {
          if (state is BookmarkScreenLoaded) {
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () async {
                _refresh();
              },
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                children: [
                  Text(
                    "bookmarkedSeries".tr(),
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: (currentIndex <= originalData.length)
                        ? data.length + 1
                        : data.length,
                    itemBuilder: (context, index) {
                      if (index == data.length) {
                        if (index == originalData.length) {
                          return SizedBox();
                        } else {
                          return Container(
                              child: Center(
                                  child: CustomCircularProgressIndicator()));
                        }
                      } else {
                        return BookmarkItem(bookmarkModel: data[index]);
                      }
                    },
                  ),
                ],
              ),
            );
          } else if (state is BookmarkScreenError) {
            return ErrorPage(callback: _refresh());
          } else {
            return buildBookmarkScreenPlaceholder(context);
          }
        },
      ),
    );
  }
}
