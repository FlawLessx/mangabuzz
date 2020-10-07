import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../widget/refresh_snackbar.dart';
import '../../widget/search_bar.dart';
import 'bloc/bookmark_screen_bloc.dart';
import 'bookmark_item.dart';
import 'bookmark_placeholder.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  int offset = 0;

  _loadMore(int count) {
    setState(() {
      offset += count;
    });
    BlocProvider.of<BookmarkScreenBloc>(context)
        .add(GetBookmarkScreenData(limit: 20, offset: offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: SearchBar(
        text: "Search bookmark...",
        function: () {},
      ),
      body: BlocConsumer<BookmarkScreenBloc, BookmarkScreenState>(
        listener: (context, state) {
          Scaffold.of(context).showSnackBar(refreshSnackBar(() {
            BlocProvider.of<BookmarkScreenBloc>(context)
                .add(GetBookmarkScreenData(limit: 20, offset: 0));
          }));
        },
        builder: (context, state) {
          if (state is BookmarkScreenLoaded) {
            return LazyLoadScrollView(
              onEndOfPage: () => _loadMore(state.listBookmarkData.length),
              child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                children: [
                  Text(
                    "Bookmarked Series",
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                        children: state.listBookmarkData
                            .map((e) => BookmarkItem(bookmarkModel: e))
                            .toList()),
                  )
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
