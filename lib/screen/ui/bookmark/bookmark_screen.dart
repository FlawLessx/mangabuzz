import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/bloc/search_bloc/search_bloc.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';
import 'package:mangabuzz/screen/ui/error/error_screen.dart';
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
  final _scrollThreshold = 500;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  _loadMore() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<BookmarkScreenBloc>(context).add(GetBookmarkScreenData());
    }
  }

  _refresh() {
    BlocProvider.of<BookmarkScreenBloc>(context)
        .add(ResetBookmarkScreenBlocToInitialState());
    BlocProvider.of<BookmarkScreenBloc>(context).add(GetBookmarkScreenData());
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
        text: getTranslated(context, "searchBookmark"),
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
                _refresh();
              },
              child: ListView(
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                children: [
                  Text(
                    getTranslated(context, "bookmarkedSeries"),
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
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
                          ? SizedBox()
                          : BookmarkItem(
                              bookmarkModel: state.listBookmarkData[index])),
                ],
              ),
            );
          } else if (state is BookmarkScreenError) {
            return RefreshIndicator(
                onRefresh: () async {
                  _refresh();
                },
                child: ErrorPage());
          } else {
            return buildBookmarkScreenPlaceholder(context);
          }
        },
      ),
    );
  }
}
