import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'core/bloc/history_bloc/history_bloc.dart';
import 'core/bloc/search_bloc/search_bloc.dart';
import 'core/provider/local/moor_db_provider.dart';
import 'core/provider/remote/api_provider.dart';
import 'core/repository/local/moor_repository.dart';
import 'core/repository/remote/api_repository.dart';
import 'core/util/connectivity_check.dart';
import 'core/util/route_generator.dart';
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
