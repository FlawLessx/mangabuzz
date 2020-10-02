import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/ui/explore/bloc/explore_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';

import 'core/bloc/main/app_bloc/app_bloc.dart';
import 'core/bloc/sub/bookmark_bloc/bookmark_bloc.dart';
import 'core/bloc/sub/history_bloc/history_bloc.dart';
import 'core/bloc/sub/search_bloc/search_bloc.dart';
import 'core/util/route_generator.dart';
import 'screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'screen/ui/history/bloc/history_screen_bloc.dart';
import 'screen/ui/home/bloc/home_screen_bloc.dart';

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
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(),
        ),
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
        )
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
