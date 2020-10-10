import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/screen/ui/error/error_screen.dart';
import 'package:mangabuzz/screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/paginated/paginated_screen_placeholder.dart';
import 'package:mangabuzz/screen/widget/manga_item/manga_item.dart';
import 'package:mangabuzz/screen/widget/paginated_button.dart';
import 'package:mangabuzz/screen/widget/refresh_snackbar.dart';
import 'package:mangabuzz/screen/widget/round_button.dart';

class PaginatedPageArguments {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  PaginatedPageArguments({
    @required this.name,
    @required this.endpoint,
    @required this.pageNumber,
    @required this.isGenre,
    @required this.isManga,
    @required this.isManhua,
    @required this.isManhwa,
  });
}

class PaginatedPage extends StatefulWidget {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  PaginatedPage({
    @required this.name,
    @required this.endpoint,
    @required this.pageNumber,
    @required this.isGenre,
    @required this.isManga,
    @required this.isManhua,
    @required this.isManhwa,
  });

  @override
  _PaginatedPageState createState() => _PaginatedPageState();
}

class _PaginatedPageState extends State<PaginatedPage> {
  ScrollController _scrollController;
  bool resetScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _resetScrollPosition();
      });
  }

  _resetScrollPosition() {
    if (resetScroll == true) {
      _scrollController.jumpTo(0);
      setState(() {
        resetScroll = false;
      });
    }
  }

  _getData(int pageNumber) {
    BlocProvider.of<PaginatedScreenBloc>(context).add(
        GetPaginatedScreenScreenData(
            name: widget.name,
            endpoint: widget.endpoint,
            isGenre: widget.isGenre,
            isManga: widget.isManga,
            isManhua: widget.isManhua,
            isManhwa: widget.isManhwa,
            pageNumber: pageNumber));

    setState(() {
      resetScroll = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: BlocBuilder<PaginatedScreenBloc, PaginatedScreenState>(
            builder: (context, state) {
              if (state is PaginatedScreenLoaded) {
                return Text(
                  widget.isGenre == true
                      ? "Genre ${state.name}"
                      : "List ${state.name}",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Poppins-Bold"),
                );
              } else {
                return Container();
              }
            },
          ),
          leading: SizedBox(),
          elevation: 8.0,
          actions: [
            RoundButton(
                icons: Icons.close,
                onTap: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.white,
                iconColor: Theme.of(context).primaryColor,
                enableShadow: false)
          ],
        ),
        body: BlocConsumer<PaginatedScreenBloc, PaginatedScreenState>(
          listener: (context, state) {
            if (state is PaginatedScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                _getData(widget.pageNumber);
              }));
            }
          },
          builder: (context, state) {
            if (state is PaginatedScreenLoaded) {
              return SafeArea(
                child: RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    _getData(state.paginatedManga.currentPage);
                  },
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    children: [
                      Text(
                        "Results for ${state.name}",
                        style:
                            TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: ScreenUtil().setHeight(20),
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: state.paginatedManga.result
                            .map((e) => MangaItem(manga: e, maxline: 1))
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: state.paginatedManga.previousPage != 0
                                ? true
                                : false,
                            child: PaginatedButton(
                                text: "Prev",
                                icons: Icons.chevron_left,
                                leftIcon: true,
                                function: () {
                                  _getData(state.paginatedManga.previousPage);
                                }),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                  visible:
                                      state.paginatedManga.previousPage != 0
                                          ? true
                                          : false,
                                  child: Text(
                                    state.paginatedManga.previousPage
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  )),
                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Text(
                                state.paginatedManga.currentPage.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Visibility(
                                  visible: state.paginatedManga.nextPage != 0
                                      ? true
                                      : false,
                                  child: Text(
                                    state.paginatedManga.nextPage.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(30),
                          ),
                          Visibility(
                            visible: state.paginatedManga.nextPage != 0
                                ? true
                                : false,
                            child: PaginatedButton(
                                text: "Next",
                                icons: Icons.chevron_right,
                                function: () {
                                  _getData(state.paginatedManga.nextPage);
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is PaginatedScreenError) {
              return ErrorPage();
            } else {
              return buildPaginatedScreenPlaceholder();
            }
          },
        ));
  }
}
