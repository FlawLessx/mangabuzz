import 'package:cached_network_image/cached_network_image.dart';
import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/chapter/bloc/chapter_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/chapter/chapter_screen.dart';
import 'package:mangabuzz/screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/paginated/paginated_screen.dart';
import 'package:mangabuzz/screen/widget/genre_item.dart';
import 'package:readmore/readmore.dart';

import '../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../core/util/route_generator.dart';
import '../../widget/rating.dart';
import '../../widget/refresh_snackbar.dart';
import '../../widget/round_button.dart';
import '../error/error_screen.dart';
import 'bloc/manga_detail_screen_bloc.dart';
import 'chapter_item.dart';
import 'manga_detail_placeholder.dart';

class MangaDetailPageArguments {
  final String mangaEndpoint;
  final String title;

  MangaDetailPageArguments(
      {@required this.mangaEndpoint, @required this.title});
}

class MangaDetailPage extends StatefulWidget {
  final String mangaEndpoint;
  final String title;

  MangaDetailPage({@required this.mangaEndpoint, @required this.title});

  @override
  _MangaDetailPageState createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  bool isBookmarked = false;

  _bookmarkFunction(BookmarkModel bookmarkModel, {MangaDetail mangaDetail}) {
    var tempData = BookmarkModel(
        title: mangaDetail.title,
        author: mangaDetail.author,
        description: mangaDetail.description,
        image: mangaDetail.image,
        mangaEndpoint: mangaDetail.mangaEndpoint,
        rating: mangaDetail.rating,
        type: mangaDetail.type,
        totalChapter: mangaDetail.chapterList.length,
        isNew: false);

    if (isBookmarked == true) {
      BlocProvider.of<BookmarkBloc>(context).add(DeleteBookmark(
          bookmarkModel: bookmarkModel != null ? bookmarkModel : tempData));
    } else {
      BlocProvider.of<BookmarkBloc>(context).add(InsertBookmark(
          bookmarkModel: bookmarkModel != null ? bookmarkModel : tempData));
    }

    BlocProvider.of<BookmarkScreenBloc>(context).add(ResetStateToInitial());
    BlocProvider.of<BookmarkScreenBloc>(context).add(GetBookmarkScreenData());

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  _readFunction(HistoryModel historyModel, MangaDetail mangaDetail) {
    if (historyModel == null) {
      BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
          chapterEndpoint: mangaDetail
              .chapterList[mangaDetail.chapterList.length - 1].chapterEndpoint,
          selectedIndex: (mangaDetail.chapterList.length - 1),
          mangaDetail: mangaDetail,
          historyModel: historyModel,
          fromHome: false));
      Navigator.pushNamed(context, chapterRoute,
          arguments: ChapterPageArguments(
              chapterEndpoint: mangaDetail
                  .chapterList[mangaDetail.chapterList.length - 1]
                  .chapterEndpoint,
              selectedIndex: (mangaDetail.chapterList.length - 1),
              historyModel: historyModel,
              mangaDetail: mangaDetail,
              fromHome: false));
    } else {
      BlocProvider.of<ChapterScreenBloc>(context).add(GetChapterScreenData(
          chapterEndpoint: mangaDetail
              .chapterList[historyModel.selectedIndex].chapterEndpoint,
          selectedIndex: historyModel.selectedIndex,
          mangaDetail: mangaDetail,
          historyModel: historyModel,
          fromHome: false));
      Navigator.pushNamed(context, chapterRoute,
          arguments: ChapterPageArguments(
              chapterEndpoint: mangaDetail
                  .chapterList[historyModel.selectedIndex].chapterEndpoint,
              selectedIndex: historyModel.selectedIndex,
              mangaDetail: mangaDetail,
              historyModel: historyModel,
              fromHome: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      extendBodyBehindAppBar: true,
      bottomNavigationBar:
          BlocBuilder<MangaDetailScreenBloc, MangaDetailScreenState>(
        builder: (context, state) {
          if (state is MangaDetailScreenLoaded) {
            return Container(
                height: ScreenUtil().setHeight(150),
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 2,
                      spreadRadius: 4,
                      offset: Offset(2, 0))
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    state.historyModel != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${state.historyModel.chapterReached} Chapter Reached",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Poppins-Medium")),
                              Text(
                                "${state.mangaDetail.chapterList.length - state.historyModel.chapterReached} Chapter Remaining",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          )
                        : SizedBox(),
                    InkWell(
                      onTap: () {
                        _readFunction(state.historyModel, state.mangaDetail);
                      },
                      child: Chip(
                        label: state.historyModel != null
                            ? Text("Continue Read")
                            : Text("Start Read"),
                        labelStyle: TextStyle(
                            color: Colors.white, fontFamily: "Poppins-Bold"),
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 4.0,
                        shadowColor:
                            Theme.of(context).primaryColor.withOpacity(0.8),
                      ),
                    )
                  ],
                ));
          } else {
            return SizedBox();
          }
        },
      ),
      body: SafeArea(
          child: BlocConsumer<MangaDetailScreenBloc, MangaDetailScreenState>(
        listener: (context, state) {
          if (state is MangaDetailScreenError) {
            Scaffold.of(context).showSnackBar(refreshSnackBar(() {
              BlocProvider.of<MangaDetailScreenBloc>(context).add(
                  GetMangaDetailScreenData(
                      mangaEndpoint: widget.mangaEndpoint,
                      title: widget.title));
            }));
          } else if (state is MangaDetailScreenLoaded) {
            setState(() {
              isBookmarked = state.isBookmarked;
            });
          }
        },
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
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _bookmarkFunction(state.bookmarkModel,
                              mangaDetail: state.mangaDetail);
                        });
                      },
                      child: Icon(
                        isBookmarked == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setHeight(100),
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
                          height: ScreenUtil().setWidth(420),
                          placeholder: (context, url) => ContentPlaceholder(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(420),
                          ),
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
                          fontSize: 15,
                          color: Colors.black),
                    ),
                    Text(
                      state.mangaDetail.author,
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Container(
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
                      child: ReadMoreText(
                        state.mangaDetail.description,
                        trimLines: 3,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        colorClickableText: Theme.of(context).primaryColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '...Show more',
                        trimExpandedText: ' Show less',
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
                    buildChapter(state.mangaDetail, state.historyModel)
                  ],
                )
              ],
            );
          } else if (state is MangaDetailScreenError) {
            return ErrorPage();
          } else {
            return buildMangaDetailPagePlaceholder(context);
          }
        },
      )),
    );
  }

  Widget buildChapter(MangaDetail mangaDetail, HistoryModel historyModel) {
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
            child: InkWell(
              onTap: () {
                BlocProvider.of<ChapterScreenBloc>(context).add(
                    GetChapterScreenData(
                        chapterEndpoint:
                            mangaDetail.chapterList[index].chapterEndpoint,
                        selectedIndex: index,
                        mangaDetail: mangaDetail,
                        historyModel: historyModel,
                        fromHome: false));
                Navigator.pushNamed(context, chapterRoute,
                    arguments: ChapterPageArguments(
                        chapterEndpoint:
                            mangaDetail.chapterList[index].chapterEndpoint,
                        selectedIndex: index,
                        mangaDetail: mangaDetail,
                        historyModel: historyModel,
                        fromHome: false));
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
              (e) => InkWell(
                onTap: () {
                  BlocProvider.of<PaginatedScreenBloc>(context).add(
                      GetPaginatedScreenScreenData(
                          name: e.genreName,
                          endpoint: e.genreEndpoint,
                          pageNumber: 1,
                          isGenre: true,
                          isManga: false,
                          isManhua: false,
                          isManhwa: false));
                  Navigator.pushNamed(context, paginatedRoute,
                      arguments: PaginatedPageArguments(
                          name: e.genreName,
                          endpoint: e.genreEndpoint,
                          pageNumber: 1,
                          isGenre: true,
                          isManga: false,
                          isManhua: false,
                          isManhwa: false));
                },
                child: GenreItem(
                    text: e.genreName,
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.2)),
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
