import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mangabuzz/screen/widget/drawer/bloc/drawer_widget_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widget/drawer/drawer_widget.dart';
import 'bookmark/bookmark_screen.dart';
import 'explore/bloc/explore_screen_bloc.dart';
import 'explore/explore_screen.dart';
import 'history/history_screen.dart';
import 'home/bloc/home_screen_bloc.dart';
import 'home/home_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  static List<Widget> widgetList = <Widget>[
    HomePage(),
    ExplorePage(),
    BookmarkPage(),
    HistoryPage()
  ];

  @override
  void initState() {
    super.initState();
    _getPermissions();
    BlocProvider.of<HomeScreenBloc>(context).add(GetHomeScreenData());
    BlocProvider.of<ExploreScreenBloc>(context).add(GetExploreScreenData());
    BlocProvider.of<DrawerWidgetBloc>(context).add(GetDrawerData());
  }

  _getPermissions() async {
    await [
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);

    return Scaffold(
        appBar: null,
        drawer: DrawerWidget(
          selectedIndex: 1,
        ),
        body: widgetList[_selectedIndex],
        bottomNavigationBar: bottomNavbar());
  }

  Widget bottomNavbar() {
    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.2))
        ]),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(15),
              vertical: ScreenUtil().setHeight(10),
            ),
            child: GNav(
                gap: 8,
                activeColor: Theme.of(context).primaryColor,
                color: Colors.grey,
                textStyle: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 14,
                    color: Theme.of(context).primaryColor),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.10),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    iconSize: ScreenUtil().setHeight(60),
                    text: "homeMenu".tr(),
                  ),
                  GButton(
                    icon: LineIcons.compass,
                    iconSize: ScreenUtil().setHeight(60),
                    text: "exploreMenu".tr(),
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    iconSize: ScreenUtil().setHeight(60),
                    text: "bookmarkMenu".tr(),
                  ),
                  GButton(
                    icon: LineIcons.history,
                    iconSize: ScreenUtil().setHeight(60),
                    text: "historyMenu".tr(),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ));
  }
}
