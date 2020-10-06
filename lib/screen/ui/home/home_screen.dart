import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';
import 'package:mangabuzz/screen/ui/home/bloc/home_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/home/carousell.dart';
import 'package:mangabuzz/screen/ui/home/home_placeholder.dart';
import 'package:mangabuzz/screen/widget/latest_update_item.dart';
import 'package:mangabuzz/screen/widget/manga_item.dart';
import 'package:mangabuzz/screen/widget/paginated_button.dart';
import 'package:mangabuzz/screen/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: SearchBar(
          text: "Search something...",
          function: () {},
        ),
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            if (state is HomeScreenLoaded) {
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Carousell(itemList: state.listBestSeries),
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                        Text(
                          "Hot Series Update",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold", fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  buildHotMangaUpdate(state.listHotMangaUpdate),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: Text(
                      "Latest Update",
                      style:
                          TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: buildLatestUpdateGridview(state.listLatestUpdate),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PaginatedButton(text: "Next", function: () {}),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  )
                ],
              );
            } else {
              return buildHomeScreenPlaceholder();
            }
          },
        ));
  }

  Widget buildHotMangaUpdate(List<Manga> listManga) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: listManga
            .map((item) => Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                  child: MangaItem(manga: item),
                ))
            .toList(),
      ),
    );
  }
}
