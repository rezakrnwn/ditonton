import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail _getTVSeriesDetail;
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;
  final GetWatchListStatusTVSeries _getWatchListStatusTVSeries;
  final SaveWatchlistTVSeries _saveWatchlistTVSeries;
  final RemoveWatchlistTVSeries _removeWatchlistTVSeries;

  TVSeriesDetailNotifier({
    required GetTVSeriesDetail getTVSeriesDetail,
    required GetTVSeriesRecommendations getTVSeriesRecommendations,
    required GetWatchListStatusTVSeries getWatchListStatusTVSeries,
    required SaveWatchlistTVSeries saveWatchlistTVSeries,
    required RemoveWatchlistTVSeries removeWatchlistTVSeries,
  })  : _getTVSeriesDetail = getTVSeriesDetail,
        _getTVSeriesRecommendations = getTVSeriesRecommendations,
        _getWatchListStatusTVSeries = getWatchListStatusTVSeries,
        _saveWatchlistTVSeries = saveWatchlistTVSeries,
        _removeWatchlistTVSeries = removeWatchlistTVSeries;

  late TVSeriesDetail _tvSeriesDetail;

  TVSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesState = RequestState.Empty;

  RequestState get tvSeriesState => _tvSeriesState;

  List<TVSeries> _tvSeriesRecommendations = [];

  List<TVSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedToWatchlist = false;

  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await _getTVSeriesDetail.execute(id);
    final recommendationResult = await _getTVSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _recommendationState = RequestState.Loading;
        _tvSeriesDetail = tvSeriesData;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvSeriesRecommendation) {
            _recommendationState = RequestState.Loaded;
            _tvSeriesRecommendations = tvSeriesRecommendation;
          },
        );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVSeriesDetail tvSeriesDetail) async {
    final result = await _saveWatchlistTVSeries.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tvSeriesDetail) async {
    final result = await _removeWatchlistTVSeries.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatusTVSeries.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
