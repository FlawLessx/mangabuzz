import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/localization/langguage_constants.dart';
import '../../widget/drawer/drawer_widget.dart';
import '../../widget/manga_item/manga_item.dart';
import '../../widget/paginated_button.dart';
import '../../widget/refresh_snackbar.dart';
import '../error/error_screen.dart';
import 'bloc/paginated_screen_bloc.dart';
import 'paginated_screen_placeholder.dart';

class PaginatedPageArguments {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  final int drawerSelectedIndex;
  PaginatedPageArguments(
      {@required this.name,
      @required this.endpoint,
      @required this.pageNumber,
      @required this.isGenre,
      @required this.isManga,
      @required this.isManhua,
      @required this.isManhwa,
      @required this.drawerSelectedIndex});
}

class PaginatedPage extends StatefulWidget {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  final int drawerSelectedIndex;
  PaginatedPage(
      {@required this.name,
      @required this.endpoint,
      @required this.pageNumber,
      @required this.isGenre,
      @required this.isManga,
      @required this.isManhua,
      @required this.isManhwa,
      @required this.drawerSelectedIndex});

  @override
  _PaginatedPageState createState() => _PaginatedPageState();
}

class _PaginatedPageState extends State<PaginatedPage> {
  ScrollController _scrollController;
  bool resetScroll = false;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

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
        key: key,
        drawer: DrawerWidget(selectedIndex: widget.drawerSelectedIndex),
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
          leading: (widget.isGenre != true)
              ? IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    key.currentState.openDrawer();
                  })
              : SizedBox(),
          elevation: 8.0,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: ScreenUtil().setWidth(80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
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
                        "${getTranslated(context, 'searchQuery')} ${state.name}",
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
                            .map((e) => MangaItem(
                                  manga: e,
                                  maxline: 1,
                                  isHot: false,
                                ))
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
                                text: getTranslated(
                                    context, "prevPaginatedButton"),
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
                                text: getTranslated(
                                    context, "nextPaginatedButton"),
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
              return RefreshIndicator(
                  onRefresh: () async {
                    _getData(widget.pageNumber);
                  },
                  child: ErrorPage());
            } else {
              return buildPaginatedScreenPlaceholder(context);
            }
          },
        ));
  }
}
