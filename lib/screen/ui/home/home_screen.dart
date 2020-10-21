import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../core/bloc/search_bloc/search_bloc.dart';
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
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  _refresh() {
    BlocProvider.of<HomeScreenBloc>(context).add(GetHomeScreenData());
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
          text: 'searchHome'.tr(),
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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              'hotSeriesUpdate'.tr(),
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Text(
                          "infoLatestUpdate".tr(),
                          style: TextStyle(
                              fontFamily: "Poppins-Bold", fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: buildLatestUpdateGridview(
                            state.listLatestUpdate, false),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PaginatedButton(
                              text: "nextPaginatedButton".tr(),
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
                ),
              );
            } else if (state is HomeScreenError) {
              return RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    _refresh();
                  },
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: ErrorPage())));
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
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(15),
                      right: ScreenUtil().setWidth(10)),
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
