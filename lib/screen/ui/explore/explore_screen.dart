import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
import '../../../core/model/genre/genre_model.dart';
import '../../../core/model/manga/manga_model.dart';
import '../../../core/util/route_generator.dart';
import '../../widget/genre_item.dart';
import '../../widget/manga_item/manga_item.dart';
import '../../widget/refresh_snackbar.dart';
import '../../widget/search/search_bar.dart';
import '../../widget/search/search_page.dart';
import '../error/error_screen.dart';
import '../paginated/bloc/paginated_screen_bloc.dart';
import '../paginated/paginated_screen.dart';
import 'bloc/explore_screen_bloc.dart';
import 'explore_placeholder.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  _navigateShowAllText(String name, String endpoint, int drawerSelectedIndex,
      {bool isGenre, bool isManga, bool isManhwa, bool isManhua}) {
    BlocProvider.of<PaginatedScreenBloc>(context).add(
        GetPaginatedScreenScreenData(
            name: name,
            endpoint: endpoint,
            pageNumber: 1,
            isGenre: isGenre,
            isManga: isManga,
            isManhua: isManhua,
            isManhwa: isManhwa));
    Navigator.pushNamed(context, paginatedRoute,
        arguments: PaginatedPageArguments(
            name: name,
            endpoint: endpoint,
            pageNumber: 1,
            isGenre: isGenre,
            isManga: isManga,
            isManhua: isManhua,
            isManhwa: isManhwa,
            drawerSelectedIndex: drawerSelectedIndex));
  }

  _refresh() {
    BlocProvider.of<ExploreScreenBloc>(context).add(GetExploreScreenData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
          text: 'searchHome'.tr(),
          function: () {
            showSearch(
                context: context,
                delegate: SearchWidget(
                    searchBloc: BlocProvider.of<SearchBloc>(context),
                    isFromAPI: true,
                    isBookmark: false,
                    isHistory: false));
          },
          drawerFunction: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        body: BlocConsumer<ExploreScreenBloc, ExploreScreenState>(
          listener: (context, state) {
            if (state is ExploreScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                BlocProvider.of<ExploreScreenBloc>(context)
                    .add(GetExploreScreenData());
              }));
            }
          },
          builder: (context, state) {
            if (state is ExploreScreenLoaded) {
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  _refresh();
                },
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: textMenu("Genres", () {}, isGenre: true)),
                    buildGenres(state.listGenre),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: textMenu("List Manga", () {
                          _navigateShowAllText("Manga", null, 2,
                              isGenre: false,
                              isManga: true,
                              isManhua: false,
                              isManhwa: false);
                        })),
                    buildListManga(state.listManga),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: textMenu("List Manhwa", () {
                          _navigateShowAllText("Manhwa", null, 3,
                              isGenre: false,
                              isManga: false,
                              isManhua: false,
                              isManhwa: true);
                        })),
                    buildListManga(state.listManhwa),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: textMenu("List Manhua", () {
                          _navigateShowAllText("Manhua", null, 4,
                              isGenre: false,
                              isManga: false,
                              isManhua: true,
                              isManhwa: false);
                        })),
                    buildListManga(state.listManhua)
                  ],
                ),
              );
            } else if (state is ExploreScreenError) {
              return RefreshIndicator(
                  onRefresh: () async {
                    _refresh();
                  },
                  child: ErrorPage());
            } else {
              return buildExploreScreenPlaceholder();
            }
          },
        ));
  }

  Widget textMenu(String text, Function onTap, {bool isGenre = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
        ),
        isGenre == false
            ? GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      'showAll'.tr(),
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: ScreenUtil().setWidth(60),
                    )
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Widget buildGenres(List<Genre> listGenre) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
      child: Row(
        children: listGenre.map((e) {
          return Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<PaginatedScreenBloc>(context).add(
                      GetPaginatedScreenScreenData(
                          name: e.genreSubtitle,
                          endpoint: e.genreEndpoint,
                          pageNumber: 1,
                          isGenre: true,
                          isManga: false,
                          isManhua: false,
                          isManhwa: false));
                  Navigator.pushNamed(context, paginatedRoute,
                      arguments: PaginatedPageArguments(
                          name: e.genreSubtitle,
                          endpoint: e.genreEndpoint,
                          pageNumber: 1,
                          isGenre: true,
                          isManga: false,
                          isManhua: false,
                          isManhwa: false,
                          drawerSelectedIndex: 1));
                },
                child: GenreItem(
                  text: e.genreSubtitle,
                  textColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  shadow: true,
                ),
              ));
        }).toList(),
      ),
    );
  }

  Widget buildListManga(List<Manga> list) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: list
            .map((item) => Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(15),
                  ),
                  child: MangaItem(
                    manga: item,
                    maxline: 2,
                    isHot: true,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
