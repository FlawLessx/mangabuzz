import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moor/moor.dart';

import '../../../model/best_series/best_series_model.dart';
import '../../../model/bookmark/bookmark_model.dart';
import '../../../model/history/history_model.dart';
import '../../../model/latest_update/latest_update_model.dart';
import '../../../model/manga/manga_model.dart';
import '../../../repository/local/moor_repository.dart';
import '../../../repository/remote/api_repository.dart';
import '../../../util/connectivity_check.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  APIRepository _apiRepository = APIRepository();
  var _moorDBRepository = MoorDBRepository();
  ConnectivityCheck _connectivityCheck = ConnectivityCheck();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    yield AppDataLoading();

    if (event is GetAppData) yield* _getAppDataToState(event);
  }

  Stream<AppState> _getAppDataToState(AppEvent event) async* {
    try {
      bool isConnected = await _connectivityCheck.checkConnectivity();
      if (isConnected == false) yield NoConnection();

      // Get Data From API
      List<BestSeries> listBestSeries = await _apiRepository.getBestSeries();
      final List<Manga> listHotMangaUpdate =
          await _apiRepository.getHotMangaUpdate();
      final LatestUpdate listLatestUpdate =
          await _apiRepository.getLatestUpdate(1);

      // Get Data From Local
      List<BookmarkModel> listBookmark =
          await _moorDBRepository.listAllBookmark();
      List<HistoryModel> listHistory = await _moorDBRepository.listAllHistory();

      yield AppDataLoaded(
          listBestSeries: listBestSeries,
          listHotMangaUpdate: listHotMangaUpdate,
          listLatestUpdate: listLatestUpdate,
          listBookmark: listBookmark,
          listHistory: listHistory);
    } on Exception {
      yield NoConnection();
    }
  }
}
