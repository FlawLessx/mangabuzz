import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../core/model/latest_update/latest_update_model.dart';
import '../../core/util/route_generator.dart';
import '../ui/chapter/bloc/chapter_screen_bloc.dart';
import '../ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import '../ui/manga_detail/manga_detail_screen.dart';
import '../util/color_series.dart';
import 'circular_progress.dart';
import 'tag.dart';

Widget buildLatestUpdateGridview(LatestUpdate listUpdate) {
  return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listUpdate.latestUpdateList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenUtil().setWidth(30),
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
  ColorSeries colorSeries = ColorSeries();

  String _convertUpdate(String data) {
    var result = data.split(" ");

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
                    height: ScreenUtil().setWidth(300),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              widget.item.hotTag != ""
                  ? Positioned(left: 0, top: 0, child: Tag(isHot: true))
                  : SizedBox(),
              widget.item.newTag != ""
                  ? Positioned(right: 0, top: 0, child: Tag(isHot: false))
                  : SizedBox()
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
                    Navigator.pushNamed(context, mangaDetailRoute);
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
                              height: ScreenUtil().setHeight(25),
                              width: ScreenUtil().setHeight(25),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
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
                                              mangaEndpoint:
                                                  widget.item.mangaEndpoint));
                                      Navigator.pushNamed(
                                          context, chapterRoute);
                                    },
                                    child: Text(
                                      widget.item.listNewChapter[index]
                                          .chapterName,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    _convertUpdate(widget
                                        .item.listNewChapter[index].updatedOn),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  )
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
