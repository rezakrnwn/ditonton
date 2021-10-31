import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'home_movie_event.dart';

part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;
  List<Movie> _nowPlaying = [];
  List<Movie> _popular = [];
  List<Movie> _topRated = [];

  HomeMovieBloc({
    required GetNowPlayingMovies getNowPlayingMovies,
    required GetPopularMovies getPopularMovies,
    required GetTopRatedMovies getTopRatedMovies,
  })  : _getNowPlayingMovies = getNowPlayingMovies,
        _getPopularMovies = getPopularMovies,
        _getTopRatedMovies = getTopRatedMovies,
        super(HomeMovieInitial()) {
    on<LoadHomeMovieEvent>(_loadHome);
  }

  List<Movie> get nowPlaying => _nowPlaying;

  List<Movie> get popular => _popular;

  List<Movie> get topRated => _topRated;

  void _loadHome(
    LoadHomeMovieEvent event,
    Emitter<HomeMovieState> emit,
  ) async {
    emit(HomeMovieInitial());
    final nowPlayingResult = await _getNowPlayingMovies.execute();
    final popularResult = await _getPopularMovies.execute();
    final topRatedResult = await _getTopRatedMovies.execute();
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
      emit(HomeMovieLoadedState());
    } else {
      emit(LoadHomeMovieFailureState(
        message: errorMessage,
      ));
    }
  }
}
