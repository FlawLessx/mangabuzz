import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/screen/widget/rating.dart';
import 'package:mangabuzz/screen/widget/tag.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    CachedNetworkImage(
                      imageUrl: widget.historyModel.image,
                      width: ScreenUtil().setWidth(220),
                      height: ScreenUtil().setWidth(320),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                Text(
                  widget.historyModel.title,
                  style: TextStyle(
                      fontFamily: "Poppins-SemiBold",
                      fontSize: 15,
                      color: Colors.black),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  widget.historyModel.author,
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 13,
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
                    SizedBox(width: ScreenUtil().setWidth(20)),
                    Text(
                      '${_getPercentage(widget.historyModel.totalChapter, widget.historyModel.chapterReached).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.historyModel.chapterReached} Chapter Reached",
                      style: TextStyle(fontSize: 11),
                    ),
                    Text(
                      "${widget.historyModel.totalChapter} Chapter Total",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Rating(rating: widget.historyModel.rating),
              ],
            ),
          )
        ],
      ),
    );
  }
}
