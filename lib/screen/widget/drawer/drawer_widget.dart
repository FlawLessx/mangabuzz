import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mangabuzz/core/model/drawer/drawer_model.dart';
import 'package:mangabuzz/core/util/route_generator.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isExpanded = false;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> items = [
      DrawerItem(
          text: "Home",
          function: () {
            Navigator.pushNamed(context, baseRoute);
          }),
      DrawerItem(
          text: "List Manga",
          function: () {
            Navigator.pushNamed(context, baseRoute);
          }),
      DrawerItem(
          text: "List Manhwa",
          function: () {
            Navigator.pushNamed(context, baseRoute);
          }),
      DrawerItem(
          text: "List Manhua",
          function: () {
            Navigator.pushNamed(context, baseRoute);
          }),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SvgPicture.asset("resources/img/ReadingDoodle.svg",
              color: Theme.of(context).primaryColor,
              semanticsLabel: 'Happy Reading'),
          ListTile(
            title: Text(items[0].text),
            onTap: items[0].function,
            trailing: Icon(Icons.chevron_right),
          ),
          ExpansionTile(
            title: Text("Genres"),
            children: [Text("test")],
          )
        ],
      ),
    );
  }
}
