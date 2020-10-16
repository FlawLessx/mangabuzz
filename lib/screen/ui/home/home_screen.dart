import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
import '../../../core/localization/langguage_constants.dart';
import '../../../core/model/manga/manga_model.dart';
import '../../../core/util/route_generator.dart';
import '../../widget/latest_update/latest_update_item.dart';
import '../../widget/manga_item/manga_item.dart';
import '../../widget/paginated_button.dart';
import '../../widget/refresh_snackbar.dart';
import '../../widget/search/search_bar.dart';
import '../../widget/search/search_page.dart';
import '../error/error_screen.dart';
import '../latest_update/bloc/latest_update_screen_bloc.dart';
import '../latest_update/latest_update_screen.dart';
import 'bloc/home_screen_bloc.dart';
import 'carousell.dart';
import 'home_placeholder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  _refresh() {
    BlocProvider.of<HomeScreenBloc>(context).add(GetHomeScreenData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: SearchBar(
          text: getTranslated(context, "searchHome"),
          function: () {
            showSearch(
                context: context,
                delegate: SearchWidget(
                    searchBloc: BlocProvider.of<SearchBloc>(context),
                    isFromAPI: true,
                    isBookmark: false,
                    isHistory: false));
          },
          drawerFunction: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        body: BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is HomeScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                BlocProvider.of<HomeScreenBloc>(context)
                    .add(GetHomeScreenData());
              }));
            }
          },
          builder: (context, state) {
            if (state is HomeScreenLoaded) {
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  _refresh();
                },
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Carousell(itemList: state.listBestSeries),
                          SizedBox(
                            height: ScreenUtil().setHeight(30),
                          ),
                          Text(
                            getTranslated(context, 'hotSeriesUpdate'),
                            style: TextStyle(
                                fontFamily: "Poppins-Bold", fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    buildHotMangaUpdate(state.listHotMangaUpdate),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: Text(
                        getTranslated(context, "infoLatestUpdate"),
                        style:
                            TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: buildLatestUpdateGridview(state.listLatestUpdate),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PaginatedButton(
                            text: getTranslated(context, "nextPaginatedButton"),
                            icons: Icons.chevron_right,
                            function: () {
                              BlocProvider.of<LatestUpdateScreenBloc>(context)
                                  .add(GetLatestUpdateScreenData(
                                      pageNumber:
                                          state.listLatestUpdate.nextPage));
                              Navigator.pushNamed(context, latestUpdateRoute,
                                  arguments: LatestUpdatePageArguments(
                                      pageNumber:
                                          state.listLatestUpdate.nextPage));
                            }),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    )
                  ],
                ),
              );
            } else if (state is HomeScreenError) {
              return RefreshIndicator(
                  onRefresh: () async {
                    _refresh();
                  },
                  child: ErrorPage());
            } else {
              return buildHomeScreenPlaceholder(context);
            }
          },
        ));
  }

  Widget buildHotMangaUpdate(List<Manga> listManga) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: listManga
            .map((item) => Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                  child: MangaItem(
                    manga: item,
                    maxline: 2,
                    isHot: true,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
