import 'package:flutter/material.dart';
import 'package:mangabuzz/screen/ui/base_screen.dart';
import 'package:mangabuzz/screen/ui/bookmark/bookmark_screen.dart';
import 'package:mangabuzz/screen/ui/chapter/chapter_screen.dart';
import 'package:mangabuzz/screen/ui/explore/explore_screen.dart';
import 'package:mangabuzz/screen/ui/history/history_screen.dart';
import 'package:mangabuzz/screen/ui/home/home_screen.dart';
import 'package:mangabuzz/screen/ui/manga_detail/manga_detail_screen.dart';

const String baseRoute = '/';
const String homeRoute = '/home';
const String exploreRoute = '/explore';
const String bookmarkRoute = '/bookmark';
const String historyRoute = '/history';
const String mangaDetailRoute = '/mangaDetail';
const String chapterRoute = '/chapter';
const String settingsRoute = '/settings';
const String listMangaRoute = '/manga';
const String listManhwaRoute = '/manhwa';
const String listManhuaRoute = '/manhua';

class RouteGenerator {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case baseRoute:
        return MaterialPageRoute(
            builder: (_) => BaseScreen(), settings: settings);
        break;
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
        break;
      case exploreRoute:
        return MaterialPageRoute(
            builder: (_) => ExplorePage(), settings: settings);
        break;
      case bookmarkRoute:
        return MaterialPageRoute(
            builder: (_) => BookmarkPage(), settings: settings);
        break;
      case historyRoute:
        return MaterialPageRoute(
          builder: (_) => HistoryPage(),
          settings: settings,
        );
        break;
      case mangaDetailRoute:
        final args = settings.arguments as MangaDetailPageArguments;
        return MaterialPageRoute(
            builder: (_) => MangaDetailPage(
                  mangaEndpoint: args.mangaEndpoint,
                  title: args.title,
                ),
            settings: settings);
        break;
      case chapterRoute:
        final args = settings.arguments as ChapterPageArguments;
        return MaterialPageRoute(
            builder: (_) => ChapterPage(
                  chapterEndpoint: args.chapterEndpoint,
                  selectedIndex: args.selectedIndex,
                  mangaDetail: args.mangaDetail,
                  fromHome: args.fromHome,
                  historyModel: args.historyModel,
                ),
            settings: settings);
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ),
            settings: settings);
    }
  }
}
