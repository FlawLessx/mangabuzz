import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/best_series/best_series_model.dart';
import 'package:mangabuzz/core/model/latest_update/latest_update_model.dart';
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
  final List<BestSeries> imgList = [
    BestSeries(
        title: "Black Clover",
        image: "resources/img/black clover.jpg",
        type: "Manhwa"),
    BestSeries(
        title: "One Piece",
        image: "resources/img/One-Piece.jpg",
        type: "Manga"),
  ];

  final List<Manga> manga = [
    Manga(
        title: "Dr. Stone",
        image: "resources/img/Dr-Stone.jpg",
        type: "Manga",
        rating: "7.3",
        chapter: "Ch.145"),
    Manga(
        title: "Jagaaaaaan",
        image: "resources/img/Jagaaaaaan.jpeg",
        type: "Manga",
        rating: "7.1",
        chapter: "Ch.74"),
    Manga(
        title: "Jagaaaaaan",
        image: "resources/img/Jagaaaaaan.jpeg",
        type: "Manga",
        rating: "7.1",
        chapter: "Ch.74"),
    Manga(
        title: "God Of War aok aw raajr awjiak mwmm",
        image: "resources/img/god of war.jpg",
        type: "Manhua",
        rating: "7.0",
        chapter: "Ch.100"),
  ];

  LatestUpdate latestUpdate = LatestUpdate(latestUpdateList: [
    LatestUpdateList(
        image: "resources/img/Dr-Stone.jpg",
        hotTag: "H",
        listNewChapter: [
          ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
          ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
          ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
        ]),
    LatestUpdateList(
        image: "resources/img/Dr-Stone.jpg",
        newTag: "N",
        listNewChapter: [
          ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
          ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
          ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
        ]),
    LatestUpdateList(image: "resources/img/Dr-Stone.jpg", listNewChapter: [
      ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
      ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
      ListNewChapter(chapterName: "Ch.271", updatedOn: "7 menit"),
    ])
  ]);

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
                        //bestSeriesPlaceholder(),
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
      padding: EdgeInsets.zero,
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
