import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/screen/ui/history/bloc/history_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/history/history_item.dart';
import 'package:mangabuzz/screen/ui/history/history_placeholder.dart';
import 'package:mangabuzz/screen/widget/search_bar.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryModel> list = [
    HistoryModel(
        title: "Jagaaaaaan",
        author: "Yanuar Bimantoro",
        image: "resources/img/Jagaaaaaan.jpeg",
        type: "Manhua",
        rating: "7.0",
        chapterReached: 70,
        totalChapter: 104)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(text: "Search bookmark...", function: () {}),
        body: BlocBuilder<HistoryScreenBloc, HistoryScreenState>(
          builder: (context, state) {
            if (state is HistoryScreenLoaded) {
              return ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                children: [
                  Text(
                    "Read History",
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
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
              );
            } else {
              return buildHistoryPlaceholder();
            }
          },
        ));
  }
}
