import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter/foundation.dart';

class NowPlayingTVSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;

  NowPlayingTVSeriesNotifier({
    required GetNowPlayingTVSeries getNowPlayingTVSeries,
  }) : _getNowPlayingTVSeries = getNowPlayingTVSeries;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];

  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlaying() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await _getNowPlayingTVSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesData) {
        _tvSeries = tvSeriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
