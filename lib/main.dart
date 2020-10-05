import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'core/bloc/history_bloc/history_bloc.dart';
import 'core/bloc/search_bloc/search_bloc.dart';
import 'core/util/route_generator.dart';
import 'screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'screen/ui/chapter/bloc/chapter_screen_bloc.dart';
import 'screen/ui/explore/bloc/explore_screen_bloc.dart';
import 'screen/ui/history/bloc/history_screen_bloc.dart';
import 'screen/ui/home/bloc/home_screen_bloc.dart';
import 'screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.init(allowFontScaling: true);

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('id', 'ID'), Locale('en', 'US')],
    path: 'resources/langs',
    assetLoader: JsonAssetLoader(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    RouteGenerator routeGenerator = RouteGenerator();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFa78df7)));

    return MultiBlocProvider(
      providers: [
        // Core BLoC
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<BookmarkBloc>(
          create: (context) => BookmarkBloc(),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(),
        ),

        // Sub BLoC
        BlocProvider<BookmarkScreenBloc>(
          create: (context) => BookmarkScreenBloc(),
        ),
        BlocProvider<HistoryScreenBloc>(
          create: (context) => HistoryScreenBloc(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => HomeScreenBloc(),
        ),
        BlocProvider<ExploreScreenBloc>(
          create: (context) => ExploreScreenBloc(),
        ),
        BlocProvider<MangaDetailScreenBloc>(
          create: (context) => MangaDetailScreenBloc(),
        ),
        BlocProvider<ChapterScreenBloc>(
          create: (context) => ChapterScreenBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: routeGenerator.onGenerateRoute,
        initialRoute: baseRoute,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
        ],
        supportedLocales: EasyLocalization.of(context).supportedLocales,
        locale: EasyLocalization.of(context).locale,
        title: 'Mangabuzz',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Poppins-Regular',
            primaryColor: Color(0xFFa78df7)),
      ),
    );
  }
}
