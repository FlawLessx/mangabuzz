import 'package:get_it/get_it.dart';
import 'package:mangabuzz/core/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:mangabuzz/core/bloc/history_bloc/history_bloc.dart';
import 'package:mangabuzz/core/bloc/search_bloc/search_bloc.dart';
import 'package:mangabuzz/core/provider/local/moor_db_provider.dart';
import 'package:mangabuzz/core/provider/remote/api_provider.dart';
import 'package:mangabuzz/core/repository/local/moor_repository.dart';
import 'package:mangabuzz/core/repository/remote/api_repository.dart';
import 'package:mangabuzz/core/util/connectivity_check.dart';
import 'package:mangabuzz/core/util/route_generator.dart';
import 'package:http/http.dart' as http;
import 'package:mangabuzz/screen/ui/bookmark/bloc/bookmark_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/chapter/bloc/chapter_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/explore/bloc/explore_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/history/bloc/history_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/home/bloc/home_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/latest_update/bloc/latest_update_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/settings/cubit/settings_screen_cubit.dart';
import 'package:mangabuzz/screen/widget/drawer/bloc/drawer_widget_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/app_localization.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  // BLoC
  sl.registerFactory(() => BookmarkBloc());
  sl.registerFactory(() => HistoryBloc());
  sl.registerFactory(() => SearchBloc());

  // Provider
  sl.registerLazySingleton(() => MyDatabase());
  sl.registerLazySingleton(() => APIProvider(client: sl()));
  sl.registerLazySingleton(() => http.Client);

  // Repository
  sl.registerLazySingleton(() => APIRepository());
  sl.registerLazySingleton(() => MoorDBRepository());

  // Localization
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => AppLocalization(locale: sl()));
  sl.registerLazySingleton(() => sharedPreferences);

  // Util
  sl.registerLazySingleton(() => ConnectivityCheck());
  sl.registerLazySingleton(() => RouteGenerator());

  //! Screen
  //Screen BLoC
  sl.registerFactory(() => BookmarkScreenBloc());
  sl.registerFactory(() => ChapterScreenBloc());
  sl.registerFactory(() => ExploreScreenBloc());
  sl.registerFactory(() => HistoryScreenBloc());
  sl.registerFactory(() => HomeScreenBloc());
  sl.registerFactory(() => LatestUpdateScreenBloc());
  sl.registerFactory(() => MangaDetailScreenBloc());
  sl.registerFactory(() => PaginatedScreenBloc());
  sl.registerFactory(() => SettingsScreenCubit());

  // Widget BLoC
  sl.registerFactory(() => DrawerWidgetBloc());
}
