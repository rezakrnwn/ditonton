import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;
  final GetPopularTVSeries _getPopularTVSeries;
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  var _nowPlaying = <TVSeries>[];

  List<TVSeries> get nowPlaying => _nowPlaying;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popular = <TVSeries>[];

  List<TVSeries> get popular => _popular;

  RequestState _popularState = RequestState.Empty;

  RequestState get popularState => _popularState;

  var _topRated = <TVSeries>[];

  List<TVSeries> get topRated => _topRated;

  RequestState _topRatedState = RequestState.Empty;

  RequestState get topRatedState => _topRatedState;

  String _message = '';

  String get message => _message;

  TVSeriesListNotifier({
    required GetNowPlayingTVSeries getNowPlayingTVSeries,
    required GetPopularTVSeries getPopularTVSeries,
    required GetTopRatedTVSeries getTopRatedTVSeries,
  })  : _getNowPlayingTVSeries = getNowPlayingTVSeries,
        _getPopularTVSeries = getPopularTVSeries,
        _getTopRatedTVSeries = getTopRatedTVSeries;

  Future<void> fetchNowPlaying() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await _getNowPlayingTVSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlaying = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopular() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await _getPopularTVSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularState = RequestState.Loaded;
        _popular = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRated() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await _getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedState = RequestState.Loaded;
        _topRated = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
