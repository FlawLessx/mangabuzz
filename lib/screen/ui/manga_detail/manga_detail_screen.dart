import 'package:cached_network_image/cached_network_image.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../core/util/route_generator.dart';
import '../chapter/bloc/chapter_screen_bloc.dart';
import 'bloc/manga_detail_screen_bloc.dart';
import 'chapter_item.dart';
import 'manga_detail_placeholder.dart';
import '../../widget/rating.dart';
import '../../widget/round_button.dart';

class MangaDetailPage extends StatefulWidget {
  @override
  _MangaDetailPageState createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  bool isBookmark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
          height: ScreenUtil().setHeight(150),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 2,
                spreadRadius: 4,
                offset: Offset(2, 0))
          ]),
          child: BlocBuilder<MangaDetailScreenBloc, MangaDetailScreenState>(
            builder: (context, state) {
              if (state is MangaDetailScreenLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.historyModel.chapterReached} Chapter Reached",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          "${state.historyModel.totalChapter - state.historyModel.chapterReached} Chapter Remaining",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                    Chip(
                      label: Text("Continue Read"),
                      labelStyle: TextStyle(
                          color: Colors.white, fontFamily: "Poppins-Medium"),
                      backgroundColor: Theme.of(context).primaryColor,
                      shadowColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                    )
                  ],
                );
              } else {
                return Center(child: buildBottomNavigationPlaceholder());
              }
            },
          )),
      body: SafeArea(
          child: BlocBuilder<MangaDetailScreenBloc, MangaDetailScreenState>(
        builder: (context, state) {
          if (state is MangaDetailScreenLoaded) {
            return ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                  vertical: ScreenUtil().setWidth(30)),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundButton(
                        iconColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        enableShadow: true,
                        icons: Icons.arrow_back,
                        onTap: () => Navigator.pop(context)),
                    GestureDetector(
                      child: Icon(
                        isBookmark ? Icons.favorite : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setHeight(80),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(20))),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 0))
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(20))),
                        child: CachedNetworkImage(
                          imageUrl: state.mangaDetail.image,
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setWidth(400),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text(
                      state.mangaDetail.title,
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    Text(
                      state.mangaDetail.author,
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(280),
                      child: Rating(
                        rating: state.mangaDetail.rating,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: ExpandText(
                        state.mangaDetail.description,
                        expandedHint: "Show More",
                        hideArrowOnExpanded: true,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    buildInfo(
                        state.mangaDetail.status,
                        state.mangaDetail.released,
                        state.mangaDetail.type,
                        state.mangaDetail.lastUpdated),
                    buildGenre(state.mangaDetail.genreList),
                    SizedBox(
                      height: ScreenUtil().setWidth(30),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "List Chapter",
                            style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Text(
                            "Download",
                            style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    buildChapter(state.mangaDetail)
                  ],
                )
              ],
            );
          } else {
            return buildMangaDetailPagePlaceholder(context);
          }
        },
      )),
    );
  }

  Widget buildChapter(MangaDetail mangaDetail) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(100),
            vertical: ScreenUtil().setHeight(20)),
        physics: NeverScrollableScrollPhysics(),
        itemCount: mangaDetail.chapterList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ChapterScreenBloc>(context)
                    .add(GetChapterScreenData(
                  chapterEndpoint:
                      mangaDetail.chapterList[index].chapterEndpoint,
                  selectedIndex: index,
                  mangaDetail: mangaDetail,
                ));
                Navigator.pushNamed(context, chapterRoute);
              },
              child: ChapterItem(
                chapterListData: mangaDetail.chapterList[index],
              ),
            ),
          );
        });
  }

  Widget buildGenre(List<GenreList> genreList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: ScreenUtil().setWidth(20),
        direction: Axis.horizontal,
        children: genreList
            .map(
              (e) => Chip(
                label: Text(e.genreName),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.15),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildInfo(
      String status, String released, String type, String lastUpdated) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: ScreenUtil().setHeight(30),
                    width: ScreenUtil().setHeight(30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15),
                  ),
                  Text(
                    "Status: $status",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                width: ScreenUtil().setWidth(60),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setHeight(30),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      Text(
                        "Released:",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(45)),
                    child: Text(
                      "$released",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            width: ScreenUtil().setWidth(60),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: ScreenUtil().setHeight(30),
                    width: ScreenUtil().setHeight(30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15),
                  ),
                  Text(
                    "Type: $type",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                width: ScreenUtil().setWidth(60),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setHeight(30),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      Text(
                        "Latest Update:",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(45)),
                    child: Text(
                      "$lastUpdated",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
