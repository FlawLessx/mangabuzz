import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/util/route_generator.dart';
import 'package:mangabuzz/screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/paginated/paginated_screen.dart';
import 'package:mangabuzz/screen/widget/genre_item.dart';

import '../../../core/model/genre/genre_model.dart';
import '../../../core/model/manga/manga_model.dart';
import '../../widget/manga_item/manga_item.dart';
import '../../widget/refresh_snackbar.dart';
import '../../widget/search_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(text: "Search something..", function: () {}),
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
              return ListView(
                controller: _scrollController,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: textMenu("Genres", () {})),
                  buildGenres(state.listGenre),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: textMenu("List Manga", () {})),
                  buildListManga(state.listManga),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: textMenu("List Manhwa", () {})),
                  buildListManga(state.listManhwa),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: textMenu("List Manhua", () {})),
                  buildListManga(state.listManhua)
                ],
              );
            } else {
              return buildExploreScreenPlaceholder();
            }
          },
        ));
  }

  Widget textMenu(String text, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                "Show All",
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
        ),
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
                          isManhwa: false));
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
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                  child: MangaItem(manga: item),
                ))
            .toList(),
      ),
    );
  }
}
