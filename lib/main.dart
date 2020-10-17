import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'core/bloc/history_bloc/history_bloc.dart';
import 'core/bloc/search_bloc/search_bloc.dart';
import 'core/util/route_generator.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'screen/ui/chapter/bloc/chapter_screen_bloc.dart';
import 'screen/ui/explore/bloc/explore_screen_bloc.dart';
import 'screen/ui/history/bloc/history_screen_bloc.dart';
import 'screen/ui/home/bloc/home_screen_bloc.dart';
import 'screen/ui/latest_update/bloc/latest_update_screen_bloc.dart';
import 'screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import 'screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'screen/ui/settings/cubit/settings_screen_cubit.dart';
import 'screen/widget/drawer/bloc/drawer_widget_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.init(
    allowFontScaling: true,
  );
  await di.init();
  await FlutterDownloader.initialize(
      debug: false // optional: set false to disable printing logs to console
      );

  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('id', 'ID')],
      path: "resources/langs/langs.csv",
      fallbackLocale: Locale('en', 'US'),
      assetLoader: CsvAssetLoader(),
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider<BookmarkBloc>(
          create: (context) => sl<BookmarkBloc>(),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => sl<HistoryBloc>(),
        ),

        // Sub BLoC / Screen BLoC
        BlocProvider<BookmarkScreenBloc>(
          create: (context) => sl<BookmarkScreenBloc>(),
        ),
        BlocProvider<HistoryScreenBloc>(
          create: (context) => sl<HistoryScreenBloc>(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => sl<HomeScreenBloc>(),
        ),
        BlocProvider<ExploreScreenBloc>(
          create: (context) => sl<ExploreScreenBloc>(),
        ),
        BlocProvider<MangaDetailScreenBloc>(
          create: (context) => sl<MangaDetailScreenBloc>(),
        ),
        BlocProvider<ChapterScreenBloc>(
          create: (context) => sl<ChapterScreenBloc>(),
        ),
        BlocProvider<PaginatedScreenBloc>(
          create: (context) => sl<PaginatedScreenBloc>(),
        ),
        BlocProvider<LatestUpdateScreenBloc>(
          create: (context) => sl<LatestUpdateScreenBloc>(),
        ),
        BlocProvider<SettingsScreenCubit>(
          create: (context) => sl<SettingsScreenCubit>(),
        ),

        // Widget BLoC
        BlocProvider<DrawerWidgetBloc>(
          create: (context) => sl<DrawerWidgetBloc>(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: routeGenerator.onGenerateRoute,
        initialRoute: baseRoute,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        title: 'Mangabuzz',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Poppins-Regular',
            primaryColor: Color(0xFFa78df7)),
      ),
    );
  }
}
