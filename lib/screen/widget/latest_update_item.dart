import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/latest_update/latest_update_model.dart';

class LatestUpdateItem extends StatefulWidget {
  final LatestUpdateList item;
  LatestUpdateItem({@required this.item});

  @override
  _LatestUpdateItemState createState() => _LatestUpdateItemState();
}

class _LatestUpdateItemState extends State<LatestUpdateItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
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
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20))),
              child: Image.asset(
                widget.item.image,
                fit: BoxFit.cover,
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setWidth(280),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Stone",
                maxLines: 1,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 16),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: widget.item.listNewChapter
                    .map((e) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(30),
                                width: ScreenUtil().setHeight(30),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amberAccent),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(5)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.chapterName,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      SizedBox(
                                          width: ScreenUtil().setWidth(20)),
                                      Text(
                                        e.updatedOn,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
