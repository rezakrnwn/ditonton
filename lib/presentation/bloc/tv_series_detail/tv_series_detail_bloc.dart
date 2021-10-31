import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail _getTVSeriesDetail;
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;
  final GetWatchListStatusTVSeries _getWatchListStatusTVSeries;
  final SaveWatchlistTVSeries _saveWatchlistTVSeries;
  final RemoveWatchlistTVSeries _removeWatchlistTVSeries;

  late TVSeriesDetail _tvSeriesDetail;
  List<TVSeries> _tvSeriesRecommendations = [];
  bool _isAddedToWatchlist = false;
  String _genres = "";

  TVSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  List<TVSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String get genres => _genres;

  TvSeriesDetailBloc({
    required GetTVSeriesDetail getTVSeriesDetail,
    required GetTVSeriesRecommendations getTVSeriesRecommendations,
    required GetWatchListStatusTVSeries getWatchListStatusTVSeries,
    required SaveWatchlistTVSeries saveWatchlistTVSeries,
    required RemoveWatchlistTVSeries removeWatchlistTVSeries,
  })  : _getTVSeriesDetail = getTVSeriesDetail,
        _getTVSeriesRecommendations = getTVSeriesRecommendations,
        _getWatchListStatusTVSeries = getWatchListStatusTVSeries,
        _saveWatchlistTVSeries = saveWatchlistTVSeries,
        _removeWatchlistTVSeries = removeWatchlistTVSeries,
        super(TVSeriesDetailInitial()) {
    on<LoadTVSeriesDetailEvent>(_loadDetail);
    on<AddTVSeriesWatchlistEvent>(_addWatchlist);
    on<RemoveTVSeriesWatchlistEvent>(_removeFromWatchlist);
  }

  void _loadDetail(
    LoadTVSeriesDetailEvent event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    emit(TVSeriesDetailInitial());
    final detailResult = await _getTVSeriesDetail.execute(event.id);
    final recommendationResult =
        await _getTVSeriesRecommendations.execute(event.id);
    final statusResult = await _getWatchListStatusTVSeries.execute(event.id);
    _isAddedToWatchlist = statusResult;
    detailResult.fold(
      (failure) {
        emit(LoadTVSeriesDetailFailureState(message: failure.message));
      },
      (tvSeriesData) {
        _tvSeriesDetail = tvSeriesData;
        _genres = _toGenresString(tvSeriesDetail.genres);
        recommendationResult.fold(
          (failure) {
            emit(LoadTVSeriesDetailFailureState(message: failure.message));
          },
          (tvSeriesRecommendation) {
            _tvSeriesRecommendations = tvSeriesRecommendation;
          },
        );
        emit(TVSeriesDetailLoadedState());
      },
    );
  }

  void _addWatchlist(
    AddTVSeriesWatchlistEvent event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    emit(TVSeriesDetailLoadingState());
    final result = await _saveWatchlistTVSeries.execute(event.tvSeriesDetail);

    await result.fold(
      (failure) async {
        emit(FailedAddOrRemoveWatchlistState(message: failure.message));
      },
      (successMessage) async {
        _isAddedToWatchlist = true;
        emit(SuccessAddOrRemoveWatchlistState(message: successMessage));
      },
    );
  }

  void _removeFromWatchlist(
    RemoveTVSeriesWatchlistEvent event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    emit(TVSeriesDetailLoadingState());
    final result = await _removeWatchlistTVSeries.execute(event.tvSeriesDetail);

    await result.fold(
      (failure) async {
        emit(FailedAddOrRemoveWatchlistState(message: failure.message));
      },
      (successMessage) async {
        _isAddedToWatchlist = false;
        emit(SuccessAddOrRemoveWatchlistState(message: successMessage));
      },
    );
  }

  String _toGenresString(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
