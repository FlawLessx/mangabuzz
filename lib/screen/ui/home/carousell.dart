import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/model/best_series/best_series_model.dart';
import '../../../core/util/route_generator.dart';
import '../../util/color_series.dart';
import '../manga_detail/bloc/manga_detail_screen_bloc.dart';
import '../manga_detail/manga_detail_screen.dart';

class Carousell extends StatefulWidget {
  final List<BestSeries> itemList;
  Carousell({@required this.itemList});

  @override
  _CarousellState createState() => _CarousellState();
}

class _CarousellState extends State<Carousell> {
  int _current = 0;
  ColorSeries colorSeries = ColorSeries();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              reverse: false,
              autoPlay: true,
              initialPage: 0,
              aspectRatio: 2.0,
              viewportFraction: 1,
              enlargeCenterPage: true,
              height: ScreenUtil().setHeight(370),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: widget.itemList
              .map((item) => GestureDetector(
                    onTap: () {
                      BlocProvider.of<MangaDetailScreenBloc>(context).add(
                          GetMangaDetailScreenData(
                              mangaEndpoint: item.mangaEndpoint,
                              title: item.title));
                      Navigator.pushNamed(context, mangaDetailRoute,
                          arguments: MangaDetailPageArguments(
                              mangaEndpoint: item.mangaEndpoint,
                              title: item.title));
                    },
                    child: Container(
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(20))),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: item.image,
                                width: ScreenUtil().setWidth(1100),
                                height: ScreenUtil().setHeight(370),
                                filterQuality: FilterQuality.high,
                                placeholder: (context, url) => Container(
                                  child: Center(
                                    child: SizedBox(
                                        height: ScreenUtil().setWidth(60),
                                        width: ScreenUtil().setWidth(60),
                                        child:
                                            CustomCircularProgressIndicator()),
                                  ),
                                ),
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: ScreenUtil().setHeight(200),
                                  decoration: BoxDecoration(
                                      color:
                                          colorSeries.generateColor(item.type),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              ScreenUtil().setWidth(20)))),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(10)),
                                    child: Text(
                                      item.type,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Semibold'),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: ScreenUtil().setHeight(120),
                                  width: double.infinity,
                                  color: Colors.black45,
                                  child: Center(
                                    child: Text(
                                      item.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        AnimatedSmoothIndicator(
          activeIndex: _current,
          count: widget.itemList.length,
          effect: WormEffect(
              radius: ScreenUtil().setHeight(30),
              dotWidth: ScreenUtil().setHeight(30),
              dotHeight: ScreenUtil().setHeight(30),
              dotColor: Colors.grey.withOpacity(0.5),
              activeDotColor: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}
