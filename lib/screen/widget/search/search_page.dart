import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/bloc/search_bloc/search_bloc.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';
import 'package:mangabuzz/screen/ui/bookmark/bookmark_item.dart';
import 'package:mangabuzz/screen/ui/history/history_item.dart';
import 'package:mangabuzz/screen/widget/manga_item/manga_item.dart';

import '../circular_progress.dart';

class SearchWidget extends SearchDelegate<Manga> {
  final Bloc<SearchEvent, SearchState> searchBloc;
  final bool isFromAPI;
  final bool isBookmark;
  final bool isHistory;
  SearchWidget(
      {@required this.searchBloc,
      @required this.isFromAPI,
      @required this.isBookmark,
      @required this.isHistory});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  _addBlocEventFunction() {
    if (isFromAPI == true) {
      searchBloc.add(SearchManga(query: query));
    } else if (isBookmark == true) {
      searchBloc.add(SearchBookmark(query: query));
    } else {
      searchBloc.add(SearchHistory(query: query));
    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
          searchBloc.add(ResetSearchBlocToInitialState());
          FocusScope.of(context).unfocus();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    _addBlocEventFunction();

    return body();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return body();
  }

  Widget body() {
    return SafeArea(
        child: ListView(
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      children: [
        Text(
          "Results for '$query'",
          style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchMangaLoaded) {
              return Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceAround,
                runSpacing: ScreenUtil().setHeight(20),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: state.listManga
                    .map((e) => MangaItem(manga: e, maxline: 1))
                    .toList(),
              );
            } else if (state is SearchBookmarkLoaded) {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.listBookmark.length,
                  itemBuilder: (context, index) =>
                      BookmarkItem(bookmarkModel: state.listBookmark[index]));
            } else if (state is SearchHistoryLoaded) {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.listHistory.length,
                  itemBuilder: (context, index) =>
                      HistoryItem(historyModel: state.listHistory[index]));
            } else if (state is SearchLoading) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: SizedBox(
                      height: ScreenUtil().setWidth(120),
                      width: ScreenUtil().setWidth(120),
                      child: CustomCircularProgressIndicator()),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        )
      ],
    ));
  }
}
