import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/model/genre/genre_model.dart';
import '../../../core/model/manga/manga_model.dart';
import '../../widget/manga_item.dart';
import '../../widget/refresh_snackbar.dart';
import '../../widget/search_bar.dart';
import 'bloc/explore_screen_bloc.dart';
import 'explore_placeholder.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(text: "Search something..", function: () {}),
        body: BlocConsumer<ExploreScreenBloc, ExploreScreenState>(
          listener: (context, state) {
            Scaffold.of(context).showSnackBar(refreshSnackBar(() {
              BlocProvider.of<ExploreScreenBloc>(context)
                  .add(GetExploreScreenData());
            }));
          },
          builder: (context, state) {
            if (state is ExploreScreenLoaded) {
              return ListView(
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20)),
                    child: buildListManga(state.listManga),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: textMenu("List Manhwa", () {})),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20)),
                    child: buildListManga(state.listManhwa),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: textMenu("List Manhua", () {})),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20)),
                    child: buildListManga(state.listManhua),
                  )
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
            child: Chip(
              label: Text(e.genreSubtitle),
              labelStyle: TextStyle(color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
              shadowColor: Theme.of(context).primaryColor.withOpacity(0.6),
              elevation: 4.0,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildListManga(List<Manga> list) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
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
