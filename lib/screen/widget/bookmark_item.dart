import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/screen/widget/tag.dart';

class BookmarkItem extends StatefulWidget {
  final BookmarkModel bookmarkModel;
  BookmarkItem({@required this.bookmarkModel});

  @override
  _BookmarkItemState createState() => _BookmarkItemState();
}

class _BookmarkItemState extends State<BookmarkItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
                    /*  CachedNetworkImage(
                      imageUrl: "http://via.placeholder.com/350x150",
                      width: ScreenUtil().setWidth(220),
                      height: ScreenUtil().setWidth(320),
                      placeholder: (context, url) => ContentPlaceholder(),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),*/

                    Image.asset(
                      widget.bookmarkModel.image,
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(250),
                      height: ScreenUtil().setWidth(350),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        child: TypeTag(
                          type: widget.bookmarkModel.type,
                          fontSize: 13,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.bookmarkModel.title,
                      style: TextStyle(
                          fontFamily: "Poppins-SemiBold",
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    Container(
                      child: Text(
                        "New Chapter Released",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  widget.bookmarkModel.author,
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 14,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  widget.bookmarkModel.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RatingBarIndicator(
                            rating:
                                double.parse(widget.bookmarkModel.rating) / 2,
                            itemCount: 5,
                            itemSize: ScreenUtil().setHeight(40),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                          Text(
                            widget.bookmarkModel.rating,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setHeight(20)))),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                            child: Text(
                              'Detail',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 14),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
