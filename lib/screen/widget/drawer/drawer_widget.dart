import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../core/model/drawer/drawer_model.dart';
import '../../../core/util/route_generator.dart';
import '../../ui/paginated/bloc/paginated_screen_bloc.dart';
import '../../ui/paginated/paginated_screen.dart';
import '../genre_item.dart';
import 'bloc/drawer_widget_bloc.dart';

class DrawerWidget extends StatefulWidget {
  final int selectedIndex;

  DrawerWidget({@required this.selectedIndex, Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> items = [
      DrawerItem(
          text: "homeMenu".tr(),
          icons: LineIcons.home,
          selectedIndex: 1,
          function: () {
            Navigator.pushNamed(context, baseRoute);
          }),
      DrawerItem(
          text: "List Manga",
          icons: LineIcons.bomb,
          selectedIndex: 2,
          function: () {
            BlocProvider.of<PaginatedScreenBloc>(context).add(
                GetPaginatedScreenScreenData(
                    name: "Manga",
                    endpoint: null,
                    pageNumber: 1,
                    isGenre: false,
                    isManga: true,
                    isManhua: false,
                    isManhwa: false));
            Navigator.pushNamed(context, paginatedRoute,
                arguments: PaginatedPageArguments(
                    name: "Manga",
                    endpoint: null,
                    pageNumber: 1,
                    isGenre: false,
                    isManga: true,
                    isManhua: false,
                    isManhwa: false,
                    drawerSelectedIndex: 2));
          }),
      DrawerItem(
          text: "List Manhwa",
          icons: LineIcons.bolt,
          selectedIndex: 3,
          function: () {
            BlocProvider.of<PaginatedScreenBloc>(context).add(
                GetPaginatedScreenScreenData(
                    name: "Manhwa",
                    endpoint: null,
                    pageNumber: 1,
                    isGenre: false,
                    isManga: false,
                    isManhua: false,
                    isManhwa: true));
            Navigator.pushNamed(context, paginatedRoute,
                arguments: PaginatedPageArguments(
                    name: "Manhwa",
                    endpoint: null,
                    pageNumber: 1,
                    isGenre: false,
                    isManga: false,
                    isManhua: false,
                    isManhwa: true,
                    drawerSelectedIndex: 3));
          }),
      DrawerItem(
          text: "List Manhua",
          icons: LineIcons.chain,
          selectedIndex: 4,
          function: () {
            BlocProvider.of<PaginatedScreenBloc>(context).add(
                GetPaginatedScreenScreenData(
                    name: "Manhua",
                    endpoint: null,
                    pageNumber: 1,
                    isGenre: false,
                    isManga: false,
                    isManhua: true,
                    isManhwa: false));
            Navigator.pushNamed(context, paginatedRoute,
                arguments: PaginatedPageArguments(
                    name: "Manhua",
                    endpoint: null,
                    pageNumber: 1,
                    isGenre: false,
                    isManga: false,
                    isManhua: true,
                    isManhwa: false,
                    drawerSelectedIndex: 4));
          }),
    ];

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset(
                "resources/img/ReadingDoodle.png",
                height: ScreenUtil().setHeight(500),
                width: ScreenUtil().setHeight(500),
              ),
            ),
            Column(
              children: items
                  .map(
                    (e) => Container(
                      color: e.selectedIndex == widget.selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      child: ListTile(
                        leading: Icon(
                          e.icons,
                          color: e.selectedIndex == widget.selectedIndex
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          e.text,
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              color: e.selectedIndex == widget.selectedIndex
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        onTap: e.function,
                        trailing: Icon(
                          Icons.chevron_right,
                          color: e.selectedIndex == widget.selectedIndex
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            ExpansionTile(
                onExpansionChanged: (status) {
                  setState(() {
                    isExpanded = status;
                  });
                },
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
                leading: Icon(
                  LineIcons.tag,
                  color: Colors.black,
                ),
                title: Text(
                  "genres".tr(),
                  style: TextStyle(
                      fontFamily: "Poppins-Bold", color: Colors.black),
                ),
                children: [
                  BlocBuilder<DrawerWidgetBloc, DrawerWidgetState>(
                    builder: (context, state) {
                      if (state is DrawerWidgetLoaded) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(10)),
                          child: Wrap(
                            spacing: ScreenUtil().setWidth(10),
                            children: isExpanded == false
                                ? []
                                : state.genreList
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<
                                                        PaginatedScreenBloc>(
                                                    context)
                                                .add(
                                                    GetPaginatedScreenScreenData(
                                                        name: e.genreSubtitle,
                                                        endpoint:
                                                            e.genreEndpoint,
                                                        pageNumber: 1,
                                                        isGenre: true,
                                                        isManga: false,
                                                        isManhua: false,
                                                        isManhwa: false));
                                            Navigator.pushNamed(
                                                context, paginatedRoute,
                                                arguments:
                                                    PaginatedPageArguments(
                                                        name: e.genreSubtitle,
                                                        endpoint:
                                                            e.genreEndpoint,
                                                        pageNumber: 1,
                                                        isGenre: true,
                                                        isManga: false,
                                                        isManhua: false,
                                                        isManhwa: false,
                                                        drawerSelectedIndex:
                                                            1));
                                          },
                                          child: GenreItem(
                                              text: e.genreSubtitle,
                                              textColor: Colors.white,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor),
                                        ))
                                    .toList(),
                          ),
                        );
                      } else {
                        return ContentPlaceholder(
                          width: ScreenUtil().setWidth(400),
                          height: ScreenUtil().setHeight(40),
                        );
                      }
                    },
                  ),
                ]),
            Container(
              color: 5 == widget.selectedIndex
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color:
                      5 == widget.selectedIndex ? Colors.white : Colors.black,
                ),
                title: Text(
                  "settingsName".tr(),
                  style: TextStyle(
                      fontFamily: "Poppins-Bold",
                      color: 5 == widget.selectedIndex
                          ? Colors.white
                          : Colors.black),
                ),
                onTap: () {
                  Navigator.pushNamed(context, settingsRoute);
                },
                trailing: Icon(
                  Icons.chevron_right,
                  color:
                      5 == widget.selectedIndex ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
