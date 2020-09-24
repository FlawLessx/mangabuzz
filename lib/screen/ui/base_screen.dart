import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mangabuzz/generated/locale_keys.g.dart';
import 'package:mangabuzz/screen/ui/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  static List<Widget> widgetList = <Widget>[HomePage(), Text("WOOOOW")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      body: widgetList.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
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
                      Theme.of(context).primaryColor.withOpacity(0.3),
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      iconSize: ScreenUtil().setHeight(60),
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.search,
                      iconSize: ScreenUtil().setHeight(60),
                      text: 'Explore',
                    ),
                    GButton(
                      icon: Icons.favorite_border,
                      iconSize: ScreenUtil().setHeight(60),
                      text: 'Bookmark',
                    ),
                    GButton(
                      icon: LineIcons.history,
                      iconSize: ScreenUtil().setHeight(60),
                      text: 'History',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          )),
    );
  }
}
