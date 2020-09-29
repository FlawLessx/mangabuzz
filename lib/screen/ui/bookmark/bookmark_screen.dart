import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/bookmark/bookmark_item.dart';
import 'package:mangabuzz/screen/ui/bookmark/bookmark_placeholder.dart';
import 'package:mangabuzz/screen/widget/search_bar.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  int offset = 0;

  List<BookmarkModel> list = [
    BookmarkModel(
        title: "One Piece",
        author: "Eichiro Oda",
        image: "resources/img/Dr-Stone.jpg",
        type: "Manga",
        rating: "9.1",
        description:
            "awokaokaowoa aowjaoja naiwdnaiunwa arihawiuhqui awrhaihwiahr awirhaiwraiw awoiraowroawh aworaowrhaowhr aowrhoawir oawoaewh")
  ];

  _loadMore(int count) {
    setState(() {
      offset += count;
    });
    BlocProvider.of<BookmarkScreenBloc>(context)
        .add(GetBookmarkScreenData(limit: 5, offset: offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: SearchBar(
        text: "Search bookmark...",
        function: () {},
      ),
      body: BlocBuilder<BookmarkScreenBloc, BookmarkScreenState>(
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
                        children: list
                            .map((e) => BookmarkItem(bookmarkModel: e))
                            .toList()),
                  )
                ],
              ),
            );
          } else {
            return buildBookmarkPlaceholder();
          }
        },
      ),
    );
  }
}
