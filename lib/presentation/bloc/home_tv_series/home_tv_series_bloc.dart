import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'home_tv_series_event.dart';

part 'home_tv_series_state.dart';

class HomeTVSeriesBloc extends Bloc<HomeTVSeriesEvent, HomeTVSeriesState> {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;
  final GetPopularTVSeries _getPopularTVSeries;
  final GetTopRatedTVSeries _getTopRatedTVSeries;
  List<TVSeries> _nowPlaying = [];
  List<TVSeries> _popular = [];
  List<TVSeries> _topRated = [];

  HomeTVSeriesBloc({
    required GetNowPlayingTVSeries getNowPlayingTVSeries,
    required GetPopularTVSeries getPopularTVSeries,
    required GetTopRatedTVSeries getTopRatedTVSeries,
  })  : _getNowPlayingTVSeries = getNowPlayingTVSeries,
        _getPopularTVSeries = getPopularTVSeries,
        _getTopRatedTVSeries = getTopRatedTVSeries,
        super(HomeTVSeriesInitial()) {
    on<LoadHomeTVSeriesEvent>(_loadHome);
  }

  List<TVSeries> get nowPlaying => _nowPlaying;

  List<TVSeries> get popular => _popular;

  List<TVSeries> get topRated => _topRated;

  void _loadHome(
    LoadHomeTVSeriesEvent event,
    Emitter<HomeTVSeriesState> emit,
  ) async {
    emit(HomeTVSeriesInitial());
    final nowPlayingResult = await _getNowPlayingTVSeries.execute();
    final popularResult = await _getPopularTVSeries.execute();
    final topRatedResult = await _getTopRatedTVSeries.execute();
    int countResult = 0;
    String errorMessage = "";
    nowPlayingResult.fold((failure) {
      errorMessage = failure.message;
    }, (movie) {
      countResult++;
      _nowPlaying = movie;
    });

    if (countResult == 1) {
      popularResult.fold((failure) {
        errorMessage = failure.message;
      }, (movie) {
        countResult++;
        _popular = movie;
      });
    }

    if (countResult == 2) {
      topRatedResult.fold((failure) {
        errorMessage = failure.message;
      }, (movie) {
        countResult++;
        _topRated = movie;
      });
    }

    if (countResult == 3) {
      emit(HomeTVSeriesLoadedState());
    } else {
      emit(LoadHomeTVSeriesFailureState(
        message: errorMessage,
      ));
    }
  }
}
