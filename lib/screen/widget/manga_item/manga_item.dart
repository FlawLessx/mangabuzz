import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/model/manga/manga_model.dart';
import '../../../core/util/route_generator.dart';
import '../../ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import '../../ui/manga_detail/manga_detail_screen.dart';
import '../circular_progress.dart';
import '../tag.dart';

class MangaItem extends StatefulWidget {
  final Manga manga;
  final bool isHot;
  final int maxline;
  MangaItem(
      {@required this.manga, @required this.maxline, @required this.isHot});

  @override
  _MangaItemState createState() => _MangaItemState();
}

class _MangaItemState extends State<MangaItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<MangaDetailScreenBloc>(context).add(
            GetMangaDetailScreenData(
                mangaEndpoint: widget.manga.mangaEndpoint,
                title: widget.manga.title));
        Navigator.pushNamed(context, mangaDetailRoute,
            arguments: MangaDetailPageArguments(
                mangaEndpoint: widget.manga.mangaEndpoint,
                title: widget.manga.title));
      },
      child: Container(
        width: ScreenUtil().setWidth(310),
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
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 0))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(20))),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.manga.image,
                      width: ScreenUtil().setWidth(240),
                      height: ScreenUtil().setWidth(340),
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
                    widget.isHot == true ? Tag(isHot: true) : SizedBox(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        child: TypeTag(
                          type: widget.manga.type,
                          fontSize: 12,
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
              maxLines: widget.maxline,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBarIndicator(
                  rating: (double.parse(widget.manga.rating) / 2),
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
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                )
              ],
            ),
            Text(
              widget.manga.chapter,
              style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
