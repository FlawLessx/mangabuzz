import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/model/manga/manga_model.dart';
import '../../ui/bookmark/bookmark_item.dart';
import '../../ui/history/history_item.dart';
import '../circular_progress.dart';
import '../manga_item/manga_item.dart';

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

    return body(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return SafeArea(
        child: ListView(
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      children: [
        Text(
          "${'searchQuery'.tr()} '$query'",
          style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchMangaLoaded) {
              return Container(
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceAround,
                  runSpacing: ScreenUtil().setHeight(20),
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: state.listManga
                      .map((e) => MangaItem(
                            manga: e,
                            maxline: 2,
                            isHot: false,
                          ))
                      .toList(),
                ),
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
                child: Center(
                  child: CustomCircularProgressIndicator(),
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
