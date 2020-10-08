import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';

import '../../widget/refresh_snackbar.dart';
import '../../widget/search_bar.dart';
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
    _scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
  }

  _loadMore() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<BookmarkScreenBloc>(context).add(GetBookmarkScreenData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(text: "Search bookmark...", function: () {}),
        body: BlocConsumer<HistoryScreenBloc, HistoryScreenState>(
          listener: (context, state) {
            if (state is BookmarkScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                BlocProvider.of<HistoryScreenBloc>(context)
                    .add(GetHistoryScreenData());
              }));
            }
          },
          builder: (context, state) {
            if (state is HistoryScreenLoaded) {
              return ListView(
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                children: [
                  Text(
                    "Read History",
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.hasReachedMax
                          ? state.listHistoryData.length
                          : state.listHistoryData.length + 1,
                      itemBuilder: (context, index) => (index >=
                              state.listHistoryData.length)
                          ? Visibility(
                              visible: state.listHistoryData.length == 0
                                  ? false
                                  : true,
                              child: Container(
                                child: Center(
                                  child: SizedBox(
                                      height: ScreenUtil().setWidth(60),
                                      width: ScreenUtil().setWidth(60),
                                      child: CustomCircularProgressIndicator()),
                                ),
                              ),
                            )
                          : HistoryItem(
                              historyModel: state.listHistoryData[index]))
                ],
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
