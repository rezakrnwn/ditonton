import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter/foundation.dart';

class PopularTVSeriesNotifier extends ChangeNotifier {
  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVSeriesNotifier({
    required GetPopularTVSeries getPopularTVSeries,
  }) : _getPopularTVSeries = getPopularTVSeries;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];

  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopular() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await _getPopularTVSeries.execute();

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
