part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchResultMovieEvent extends SearchMovieEvent {
  final String keyword;

  LoadSearchResultMovieEvent({
    required this.keyword,
  });
}
