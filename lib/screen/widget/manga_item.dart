import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';
import 'package:mangabuzz/screen/widget/tag.dart';

class MangaItem extends StatefulWidget {
  final Manga manga;
  MangaItem({@required this.manga});

  @override
  _MangaItemState createState() => _MangaItemState();
}

class _MangaItemState extends State<MangaItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.manga.image,
                    width: ScreenUtil().setWidth(220),
                    height: ScreenUtil().setWidth(320),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Tag(isHot: true),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      child: TypeTag(
                        type: widget.manga.type,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Text(
            widget.manga.title,
            maxLines: 2,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: double.parse(widget.manga.rating) / 2,
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
                widget.manga.rating,
                style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 14),
              )
            ],
          ),
          Text(
            widget.manga.chapter,
            style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 15),
          )
        ],
      ),
    );
  }
}
