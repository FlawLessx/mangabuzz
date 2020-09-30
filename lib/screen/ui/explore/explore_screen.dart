import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/genre/genre_model.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';
import 'package:mangabuzz/screen/ui/explore/bloc/explore_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/explore/explore_placeholder.dart';
import 'package:mangabuzz/screen/widget/manga_item.dart';
import 'package:mangabuzz/screen/widget/search_bar.dart';
import 'package:random_color/random_color.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(text: "Search something..", function: () {}),
        body: BlocBuilder<ExploreScreenBloc, ExploreScreenState>(
          builder: (context, state) {
            if (state is ExploreScreenLoaded) {
              return ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: textMenu("Genres", () {})),
                  buildGenres(state.listGenre),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: textMenu("List Manga", () {})),
                  buildListManga(state.listManga),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: textMenu("List Manhwa", () {})),
                  buildListManga(state.listManhwa),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
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
          var _color = _randomColor.randomColor(
              colorBrightness: ColorBrightness.primary,
              colorSaturation: ColorSaturation.mediumSaturation);

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setWidth(20)),
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(50))),
                    color: Theme.of(context).primaryColor),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(30),
                      vertical: ScreenUtil().setWidth(10)),
                  child: Text(
                    e.genreSubtitle,
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Poppins-Medium"),
                  ),
                ))),
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
