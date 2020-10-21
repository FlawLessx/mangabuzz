import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/model/latest_update/latest_update_model.dart';
import '../../../core/util/route_generator.dart';
import '../../../injection_container.dart';
import '../../ui/chapter/bloc/chapter_screen_bloc.dart';
import '../../ui/chapter/chapter_screen.dart';
import '../../ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import '../../ui/manga_detail/manga_detail_screen.dart';
import '../../util/color_series.dart';
import '../circular_progress.dart';
import '../tag.dart';

Widget buildLatestUpdateGridview(LatestUpdate listUpdate, bool fullLength) {
  return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: fullLength == true ? listUpdate.latestUpdateList.length : 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenUtil().setWidth(10),
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 0),
      itemBuilder: (context, index) {
        return LatestUpdateItem(item: listUpdate.latestUpdateList[index]);
      });
}

class LatestUpdateItem extends StatefulWidget {
  final LatestUpdateList item;
  LatestUpdateItem({@required this.item});

  @override
  _LatestUpdateItemState createState() => _LatestUpdateItemState();
}

class _LatestUpdateItemState extends State<LatestUpdateItem> {
  final colorSeries = sl.get<ColorSeries>();

  String _convertUpdate(String data) {
    var result = data.split(" ");

    if (result[1] == 'seconds') {
      result[1] = 'sec';
    }

    return "${result[0]} ${result[1]}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<MangaDetailScreenBloc>(context).add(
                      GetMangaDetailScreenData(
                          mangaEndpoint: widget.item.mangaEndpoint,
                          title: widget.item.title));
                  Navigator.pushNamed(context, mangaDetailRoute,
                      arguments: MangaDetailPageArguments(
                          mangaEndpoint: widget.item.mangaEndpoint,
                          title: widget.item.title));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(20))),
                  child: CachedNetworkImage(
                    imageUrl: widget.item.image,
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setWidth(280),
                    placeholder: (context, url) => Container(
                      child: Center(
                        child: SizedBox(
                            height: ScreenUtil().setWidth(60),
                            width: ScreenUtil().setWidth(60),
                            child: CustomCircularProgressIndicator()),
                      ),
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              widget.item.hotTag != ""
                  ? Positioned(left: 0, top: 0, child: Tag(isHot: true))
                  : SizedBox(),
            ],
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<MangaDetailScreenBloc>(context).add(
                        GetMangaDetailScreenData(
                            mangaEndpoint: widget.item.mangaEndpoint,
                            title: widget.item.title));
                    Navigator.pushNamed(context, mangaDetailRoute,
                        arguments: MangaDetailPageArguments(
                            mangaEndpoint: widget.item.mangaEndpoint,
                            title: widget.item.title));
                  },
                  child: Text(
                    widget.item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 13),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.item.listNewChapter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(20),
                              width: ScreenUtil().setHeight(20),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorSeries
                                      .generateColor(widget.item.type)),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5)),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<ChapterScreenBloc>(
                                                context)
                                            .add(GetChapterScreenData(
                                                chapterEndpoint: widget
                                                    .item
                                                    .listNewChapter[index]
                                                    .chapterEndpoint,
                                                selectedIndex: index,
                                                mangaDetail: null,
                                                historyModel: null,
                                                fromHome: true,
                                                mangaEndpoint:
                                                    widget.item.mangaEndpoint));
                                        Navigator.pushNamed(
                                            context, chapterRoute,
                                            arguments: ChapterPageArguments(
                                                chapterEndpoint: widget
                                                    .item
                                                    .listNewChapter[index]
                                                    .chapterEndpoint,
                                                selectedIndex: index,
                                                mangaDetail: null,
                                                fromHome: true,
                                                historyModel: null,
                                                mangaEndpoint:
                                                    widget.item.mangaEndpoint));
                                      },
                                      child: AutoSizeText(
                                        widget.item.listNewChapter[index]
                                            .chapterName,
                                        minFontSize: 9,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  AutoSizeText(
                                    _convertUpdate(widget
                                        .item.listNewChapter[index].updatedOn),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11),
                                    maxLines: 1,
                                    maxFontSize: 11,
                                    minFontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
