import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/screen/ui/settings/cubit/settings_screen_cubit.dart';

import 'core/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'core/bloc/history_bloc/history_bloc.dart';
import 'core/bloc/search_bloc/search_bloc.dart';
import 'core/localization/app_localization.dart';
import 'core/localization/langguage_constants.dart';
import 'core/util/route_generator.dart';
import 'injection_container.dart';
import 'screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'screen/ui/chapter/bloc/chapter_screen_bloc.dart';
import 'screen/ui/explore/bloc/explore_screen_bloc.dart';
import 'screen/ui/history/bloc/history_screen_bloc.dart';
import 'screen/ui/home/bloc/home_screen_bloc.dart';
import 'screen/ui/latest_update/bloc/latest_update_screen_bloc.dart';
import 'screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import 'screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'screen/widget/drawer/bloc/drawer_widget_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.init(allowFontScaling: true);
  await di.init();
  await FlutterDownloader.initialize(
      debug: false // optional: set false to disable printing logs to console
      );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    RouteGenerator routeGenerator = RouteGenerator();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFa78df7)));

    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
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
          locale: _locale,
          supportedLocales: [
            Locale("en", "US"),
            Locale("id", "ID"),
          ],
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          title: 'Mangabuzz',
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Poppins-Regular',
              primaryColor: Color(0xFFa78df7)),
        ),
      );
    }
  }
}
