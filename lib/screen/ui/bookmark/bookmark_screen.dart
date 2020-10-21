import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
import '../../widget/refresh_snackbar.dart';
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
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  _refresh();
                },
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ErrorPage())));
          } else {
            return buildBookmarkScreenPlaceholder(context);
          }
        },
      ),
    );
  }
}
