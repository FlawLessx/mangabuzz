import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/bloc/search_bloc/search_bloc.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';
import 'package:mangabuzz/screen/widget/search/search_page.dart';

import '../../widget/refresh_snackbar.dart';
import '../../widget/search/search_bar.dart';
import 'bloc/bookmark_screen_bloc.dart';
import 'bookmark_item.dart';
import 'bookmark_placeholder.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
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
      extendBodyBehindAppBar: false,
      appBar: SearchBar(
        text: "Search bookmark...",
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
          if (state is BookmarkScreenError) {
            Scaffold.of(context).showSnackBar(refreshSnackBar(() {
              BlocProvider.of<BookmarkScreenBloc>(context)
                  .add(GetBookmarkScreenData());
            }));
          }
        },
        builder: (context, state) {
          if (state is BookmarkScreenLoaded) {
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
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                children: [
                  Text(
                    "Bookmarked Series",
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.hasReachedMax
                          ? state.listBookmarkData.length
                          : state.listBookmarkData.length + 1,
                      itemBuilder: (context, index) => (index >=
                              state.listBookmarkData.length)
                          ? Visibility(
                              visible:
                                  _visibleLoad(state.listBookmarkData.length),
                              child: Container(
                                child: Center(
                                  child: SizedBox(
                                      height: ScreenUtil().setWidth(60),
                                      width: ScreenUtil().setWidth(60),
                                      child: CustomCircularProgressIndicator()),
                                ),
                              ),
                            )
                          : BookmarkItem(
                              bookmarkModel: state.listBookmarkData[index])),
                ],
              ),
            );
          } else {
            return buildBookmarkScreenPlaceholder();
          }
        },
      ),
    );
  }
}
