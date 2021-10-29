import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;
  List<Movie> _result = [];

  List<Movie> get result => _result;

  SearchMovieBloc({
    required SearchMovies searchMovies,
  })  : _searchMovies = searchMovies,
        super(SearchMovieInitial()) {
    on<LoadSearchResultMovieEvent>((event, emit) async {
      emit(SearchMovieLoadingState());
      final result = await _searchMovies.execute(event.keyword);
      result.fold(
        (failure) => emit(LoadSearchMovieFailureState(
          message: failure.message,
        )),
        (data) {
          _result = data;
          emit(SearchResultMovieLoadedState());
        },
      );
    });
  }
}
