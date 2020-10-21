import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/core/model/latest_update/latest_update_model.dart';

import '../../widget/latest_update/latest_update_item.dart';
import '../../widget/latest_update/latest_update_item_placeholder.dart';
import '../../widget/paginated_button.dart';
import '../../widget/refresh_snackbar.dart';
import '../error/error_screen.dart';
import 'bloc/latest_update_screen_bloc.dart';

class LatestUpdatePageArguments {
  final int pageNumber;
  LatestUpdatePageArguments({
    @required this.pageNumber,
  });
}

class LatestUpdatePage extends StatefulWidget {
  final int pageNumber;
  LatestUpdatePage({
    @required this.pageNumber,
  });

  @override
  _LatestUpdatePageState createState() => _LatestUpdatePageState();
}

class _LatestUpdatePageState extends State<LatestUpdatePage> {
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
    BlocProvider.of<LatestUpdateScreenBloc>(context)
        .add(GetLatestUpdateScreenData(pageNumber: pageNumber));

    setState(() {
      resetScroll = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: BlocBuilder<LatestUpdateScreenBloc, LatestUpdateScreenState>(
            builder: (context, state) {
              if (state is LatestUpdateScreenLoaded) {
                return Text(
                  'infoLatestUpdate'.tr(),
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
        body: BlocConsumer<LatestUpdateScreenBloc, LatestUpdateScreenState>(
          listener: (context, state) {
            if (state is LatestUpdateScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                _getData(widget.pageNumber);
              }));
            }
          },
          builder: (context, state) {
            if (state is LatestUpdateScreenLoaded) {
              return SafeArea(
                child: RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    _getData(state.latestUpdate.currentPage);
                  },
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    children: [
                      buildLatestUpdateGridview(state.latestUpdate, true),
                      paginationWidget(state.latestUpdate),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is LatestUpdateScreenError) {
              return RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    _getData(widget.pageNumber);
                  },
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: ErrorPage())));
            } else {
              return Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                child: buildLatestUpdatePlaceholder(),
              );
            }
          },
        ));
  }

  Widget paginationWidget(LatestUpdate paginatedManga) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: paginatedManga.previousPage != 0 ? true : false,
          child: PaginatedButton(
              text: "prevPaginatedButton".tr(),
              icons: Icons.chevron_left,
              leftIcon: true,
              function: () {
                _getData(paginatedManga.previousPage);
              }),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(20),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            paginatedManga.previousPage != 0
                ? Visibility(
                    visible: paginatedManga.previousPage != 0 ? true : false,
                    child: Text(
                      paginatedManga.previousPage.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ))
                : SizedBox(
                    width: ScreenUtil().setWidth(100),
                  ),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            Text(
              paginatedManga.currentPage.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins-Medium",
                  fontSize: 16),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            Visibility(
                visible: paginatedManga.nextPage != 0 ? true : false,
                child: Text(
                  paginatedManga.nextPage.toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ))
          ],
        ),
        SizedBox(
          width: ScreenUtil().setWidth(30),
        ),
        paginatedManga.nextPage != 0
            ? Visibility(
                visible: paginatedManga.nextPage != 0 ? true : false,
                child: PaginatedButton(
                    text: "nextPaginatedButton".tr(),
                    icons: Icons.chevron_right,
                    function: () {
                      _getData(paginatedManga.nextPage);
                    }),
              )
            : SizedBox(
                width: ScreenUtil().setWidth(100),
              )
      ],
    );
  }
}
