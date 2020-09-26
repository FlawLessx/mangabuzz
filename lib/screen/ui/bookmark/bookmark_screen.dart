import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/bloc/main/app_bloc/app_bloc.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/screen/widget/bookmark_item.dart';
import 'package:mangabuzz/screen/widget/placeholder.dart';
import 'package:mangabuzz/screen/widget/search_bar.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: SearchBar(
        text: "Search bookmark...",
        function: () {},
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppDataLoaded) {
            return ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              children: [
                Text(
                  "Bookmarked Series",
                  style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 18),
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                      children: list
                          .map((e) => BookmarkItem(bookmarkModel: e))
                          .toList()),
                )
              ],
            );
          } else {
            return ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              children: [
                Text(
                  "Bookmarked Series",
                  style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 18),
                ),
                buildBookmarkPlaceholder(),
              ],
            );
          }
        },
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Gajelas"),
    );
  }
}
