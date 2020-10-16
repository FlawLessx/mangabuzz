import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mangabuzz/core/bloc/history_bloc/history_bloc.dart';
import 'package:mangabuzz/screen/ui/history/bloc/history_screen_bloc.dart';

import '../../../core/localization/langguage_constants.dart';
import '../../../core/model/history/history_model.dart';
import '../../../core/util/route_generator.dart';
import '../../widget/circular_progress.dart';
import '../../widget/rating.dart';
import '../../widget/tag.dart';
import '../manga_detail/bloc/manga_detail_screen_bloc.dart';
import '../manga_detail/manga_detail_screen.dart';

class HistoryItem extends StatefulWidget {
  final HistoryModel historyModel;
  HistoryItem({@required this.historyModel});

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  double _getPercentage(int maxValue, int currentValue) {
    return (currentValue / maxValue) * 100;
  }

  _navigate() {
    BlocProvider.of<MangaDetailScreenBloc>(context).add(
        GetMangaDetailScreenData(
            mangaEndpoint: widget.historyModel.mangaEndpoint,
            title: widget.historyModel.title));
    Navigator.pushNamed(context, mangaDetailRoute,
        arguments: MangaDetailPageArguments(
            mangaEndpoint: widget.historyModel.mangaEndpoint,
            title: widget.historyModel.title));
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            BlocProvider.of<HistoryBloc>(context).add(DeleteHistory(
                title: widget.historyModel.title,
                mangaEndpoint: widget.historyModel.mangaEndpoint));
            BlocProvider.of<HistoryScreenBloc>(context)
                .add(ResetHistoryScreenBlocToInitialState());
            BlocProvider.of<HistoryScreenBloc>(context)
                .add(GetHistoryScreenData());
          },
        ),
      ],
      child: Container(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(20))),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 0))
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(20))),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _navigate(),
                        child: CachedNetworkImage(
                          imageUrl: widget.historyModel.image,
                          width: ScreenUtil().setWidth(260),
                          height: ScreenUtil().setWidth(360),
                          placeholder: (context, url) => Container(
                            child: Center(
                              child: SizedBox(
                                  height: ScreenUtil().setWidth(60),
                                  width: ScreenUtil().setWidth(60),
                                  child: CustomCircularProgressIndicator()),
                            ),
                          ),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                          child: TypeTag(
                            type: widget.historyModel.type,
                            fontSize: 11,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _navigate(),
                    child: Text(
                      widget.historyModel.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: "Poppins-SemiBold",
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Text(
                    widget.historyModel.author,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(600),
                        child: FAProgressBar(
                          currentValue: widget.historyModel.chapterReached,
                          maxValue: widget.historyModel.totalChapter,
                          size: ScreenUtil().setHeight(20),
                          backgroundColor: Color(0xFFE5E5E5),
                          progressColor: Color(0xFF4be2c0),
                        ),
                      ),
                      Text(
                        '${_getPercentage(widget.historyModel.totalChapter, widget.historyModel.chapterReached).toStringAsFixed(0)}%',
                        style: TextStyle(
                            fontSize: 12, fontFamily: "Poppins-Medium"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.historyModel.chapterReached} ${getTranslated(context, 'chapterReached')}",
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        "${widget.historyModel.totalChapter} ${getTranslated(context, 'chapterTotal')}",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Rating(rating: widget.historyModel.rating),
                      InkWell(
                          onTap: () {
                            _navigate();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: Offset(0, 1),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.6))
                                ],
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(20))),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(30),
                                    vertical: ScreenUtil().setWidth(10)),
                                child: Text(getTranslated(context, 'continue'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-SemiBold")),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
