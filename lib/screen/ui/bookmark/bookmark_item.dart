import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/bookmark/bookmark_model.dart';
import '../../widget/rating.dart';
import '../../widget/tag.dart';

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
                      imageUrl: widget.bookmarkModel.image,
                      width: ScreenUtil().setWidth(250),
                      height: ScreenUtil().setWidth(350),
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
                          type: widget.bookmarkModel.type,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.bookmarkModel.title,
                      style: TextStyle(
                          fontFamily: "Poppins-SemiBold",
                          fontSize: 15,
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
                      fontSize: 13,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  widget.bookmarkModel.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rating(
                      rating: widget.bookmarkModel.rating,
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
                                  fontSize: 13),
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
