import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../widget/refresh_snackbar.dart';
import '../../widget/search_bar.dart';
import '../error/error_screen.dart';
import 'bloc/history_screen_bloc.dart';
import 'history_item.dart';
import 'history_placeholder.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int offset = 0;

  _loadMore(int count) {
    setState(() {
      offset += count;
    });
    BlocProvider.of<HistoryScreenBloc>(context)
        .add(GetHistoryScreenData(limit: 20, offset: offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(text: "Search bookmark...", function: () {}),
        body: BlocConsumer<HistoryScreenBloc, HistoryScreenState>(
          listener: (context, state) {
            Scaffold.of(context).showSnackBar(refreshSnackBar(() {
              BlocProvider.of<HistoryScreenBloc>(context)
                  .add(GetHistoryScreenData(limit: 20, offset: 0));
            }));
          },
          builder: (context, state) {
            if (state is HistoryScreenLoaded) {
              return LazyLoadScrollView(
                onEndOfPage: () => _loadMore(state.listHistoryData.length),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  children: [
                    Text(
                      "Read History",
                      style:
                          TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.listHistoryData.length,
                        itemBuilder: (context, index) {
                          return HistoryItem(
                              historyModel: state.listHistoryData[index]);
                        })
                  ],
                ),
              );
            } else if (state is HistoryScreenError) {
              return ErrorPage();
            } else {
              return buildHistoryScreenPlaceholder();
            }
          },
        ));
  }
}
