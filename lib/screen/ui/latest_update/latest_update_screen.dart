import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/screen/ui/error/error_screen.dart';
import 'package:mangabuzz/screen/ui/latest_update/bloc/latest_update_screen_bloc.dart';
import 'package:mangabuzz/screen/widget/latest_update/latest_update_item.dart';
import 'package:mangabuzz/screen/widget/latest_update/latest_update_item_placeholder.dart';
import 'package:mangabuzz/screen/widget/paginated_button.dart';
import 'package:mangabuzz/screen/widget/refresh_snackbar.dart';
import 'package:mangabuzz/screen/widget/round_button.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: BlocBuilder<LatestUpdateScreenBloc, LatestUpdateScreenState>(
            builder: (context, state) {
              if (state is LatestUpdateScreenLoaded) {
                return Text(
                  "Latest Update",
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
                      Text(
                        "Results for latest update",
                        style:
                            TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                      ),
                      buildLatestUpdateGridview(state.latestUpdate),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: state.latestUpdate.previousPage != 0
                                ? true
                                : false,
                            child: PaginatedButton(
                                text: "Prev",
                                icons: Icons.chevron_left,
                                leftIcon: true,
                                function: () {
                                  _getData(state.latestUpdate.previousPage);
                                }),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                  visible: state.latestUpdate.previousPage != 0
                                      ? true
                                      : false,
                                  child: Text(
                                    state.latestUpdate.previousPage.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  )),
                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Text(
                                state.latestUpdate.currentPage.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Visibility(
                                  visible: state.latestUpdate.nextPage != 0
                                      ? true
                                      : false,
                                  child: Text(
                                    state.latestUpdate.nextPage.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(30),
                          ),
                          Visibility(
                            visible:
                                state.latestUpdate.nextPage != 0 ? true : false,
                            child: PaginatedButton(
                                text: "Next",
                                icons: Icons.chevron_right,
                                function: () {
                                  _getData(state.latestUpdate.nextPage);
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
            } else if (state is LatestUpdateScreenError) {
              return ErrorPage();
            } else {
              return Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                child: buildLatestUpdatePlaceholder(),
              );
            }
          },
        ));
  }
}
