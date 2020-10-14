import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/bloc/search_bloc/search_bloc.dart';
import 'package:mangabuzz/screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';
import 'package:mangabuzz/screen/widget/search/search_page.dart';

import '../../widget/refresh_snackbar.dart';
import '../../widget/search/search_bar.dart';
import '../error/error_screen.dart';
import 'bloc/history_screen_bloc.dart';
import 'history_item.dart';
import 'history_placeholder.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ScrollController _scrollController;
  final _scrollThreshold = 200;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  _loadMore() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<BookmarkScreenBloc>(context).add(GetBookmarkScreenData());
    }
  }

  bool _visibleLoad(int length) {
    return length <= 3 ? false : true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _loadMore();
    });

    return Scaffold(
        appBar: SearchBar(
          text: "Search history...",
          function: () {
            showSearch(
                context: context,
                delegate: SearchWidget(
                    searchBloc: BlocProvider.of<SearchBloc>(context),
                    isFromAPI: false,
                    isBookmark: false,
                    isHistory: true));
          },
          drawerFunction: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        body: BlocConsumer<HistoryScreenBloc, HistoryScreenState>(
          listener: (context, state) {
            if (state is HistoryScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                BlocProvider.of<HistoryScreenBloc>(context)
                    .add(GetHistoryScreenData());
              }));
            }
          },
          builder: (context, state) {
            if (state is HistoryScreenLoaded) {
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  BlocProvider.of<BookmarkScreenBloc>(context)
                      .add(ResetBookmarkScreenBlocToInitialState());
                  BlocProvider.of<BookmarkScreenBloc>(context)
                      .add(GetBookmarkScreenData());
                },
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  children: [
                    Text(
                      "Read History",
                      style:
                          TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.hasReachedMax
                            ? state.listHistoryData.length
                            : state.listHistoryData.length + 1,
                        itemBuilder: (context, index) => (index >=
                                state.listHistoryData.length)
                            ? Visibility(
                                visible:
                                    _visibleLoad(state.listHistoryData.length),
                                child: Container(
                                  child: Center(
                                    child: SizedBox(
                                        height: ScreenUtil().setWidth(60),
                                        width: ScreenUtil().setWidth(60),
                                        child:
                                            CustomCircularProgressIndicator()),
                                  ),
                                ),
                              )
                            : HistoryItem(
                                historyModel: state.listHistoryData[index]))
                  ],
                ),
              );
            } else if (state is HistoryScreenError) {
              return ErrorPage();
            } else {
              return buildHistoryScreenPlaceholder();
            }
          },
        ));
  }
}
