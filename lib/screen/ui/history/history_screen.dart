import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/screen/widget/circular_progress.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
import '../../widget/search/search_bar.dart';
import '../../widget/search/search_page.dart';
import '../error/error_screen.dart';
import 'bloc/history_screen_bloc.dart';
import 'history_item.dart';
import 'history_placeholder.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ScrollController _scrollController;
  List<HistoryModel> originalData;
  List<HistoryModel> data;
  int currentIndex = 0;
  static const ITEM_COUNT = 10;

  @override
  void initState() {
    super.initState();
    data = [];
    originalData = [];
    _refresh();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (currentIndex != originalData.length) {
            _loadMore();
          }
        }
      });
  }

  Future _loadMore() async {
    if ((currentIndex + ITEM_COUNT) >= originalData.length) {
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          data.addAll(originalData.getRange(currentIndex, originalData.length));
          currentIndex = currentIndex + (originalData.length - currentIndex);
        });
      });
    } else {
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          data.addAll(
              originalData.getRange(currentIndex, currentIndex + ITEM_COUNT));
          currentIndex = currentIndex + ITEM_COUNT;
        });
      });
    }
  }

  _refresh() {
    BlocProvider.of<HistoryScreenBloc>(context).add(GetHistoryScreenData());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
          text: 'searchHistory'.tr(),
          function: () {
            showSearch(
                context: context,
                delegate: SearchWidget(
                    searchBloc: BlocProvider.of<SearchBloc>(context),
                    isFromAPI: false,
                    isBookmark: false,
                    isHistory: true));
          },
          drawerFunction: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        body: BlocConsumer<HistoryScreenBloc, HistoryScreenState>(
          listener: (context, state) {
            if (state is HistoryScreenLoaded) {
              data = [];
              originalData = [];

              final length = state.listHistoryData.length <= ITEM_COUNT
                  ? state.listHistoryData.length
                  : ITEM_COUNT;
              setState(() {
                currentIndex = length;
                data.addAll(state.listHistoryData.getRange(0, length));
                originalData = state.listHistoryData;
              });
            }
          },
          builder: (context, state) {
            if (state is HistoryScreenLoaded) {
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  _refresh();
                },
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  children: [
                    Text(
                      'readHistory'.tr(),
                      style:
                          TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (currentIndex <= originalData.length)
                            ? data.length + 1
                            : data.length,
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            if (index == originalData.length) {
                              return SizedBox();
                            } else {
                              return Container(
                                  child: Center(
                                      child:
                                          CustomCircularProgressIndicator()));
                            }
                          } else {
                            return HistoryItem(historyModel: data[index]);
                          }
                        }),
                  ],
                ),
              );
            } else if (state is HistoryScreenError) {
              return ErrorPage(callback: _refresh());
            } else {
              return buildHistoryScreenPlaceholder(context);
            }
          },
        ));
  }
}
