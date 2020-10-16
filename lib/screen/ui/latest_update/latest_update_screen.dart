import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/localization/langguage_constants.dart';
import '../../widget/latest_update/latest_update_item.dart';
import '../../widget/latest_update/latest_update_item_placeholder.dart';
import '../../widget/paginated_button.dart';
import '../../widget/refresh_snackbar.dart';
import '../../widget/round_button.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: BlocBuilder<LatestUpdateScreenBloc, LatestUpdateScreenState>(
            builder: (context, state) {
              if (state is LatestUpdateScreenLoaded) {
                return Text(
                  getTranslated(context, 'infoLatestUpdate'),
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
                      buildLatestUpdateGridview(state.latestUpdate),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: state.latestUpdate.previousPage != 0
                                ? true
                                : false,
                            child: PaginatedButton(
                                text: getTranslated(
                                    context, "prevPaginatedButton"),
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
                                text: getTranslated(
                                    context, "nextPaginatedButton"),
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
              return RefreshIndicator(
                  onRefresh: () async {
                    _getData(widget.pageNumber);
                  },
                  child: ErrorPage());
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
