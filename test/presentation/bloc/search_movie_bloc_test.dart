import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc bloc;
  late MockSearchMovies mockSearchMovies;
  String keyword = "Spiderman";

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchMovieBloc(searchMovies: mockSearchMovies);
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit [SearchMovieLoadingState, SearchResultMovieLoadedState] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(keyword))
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSearchResultMovieEvent(keyword: keyword)),
      expect: () => [
            SearchMovieLoadingState(),
            SearchResultMovieLoadedState(),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(keyword));
      });

  blocTest<SearchMovieBloc, SearchMovieState>(
      "should emit [SearchMovieLoadingState, LoadSearchMovieFailureState] when get data is unsuccessful",
      build: () {
        when(mockSearchMovies.execute(keyword))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSearchResultMovieEvent(keyword: keyword)),
      expect: () => [
            SearchMovieLoadingState(),
            LoadSearchMovieFailureState(message: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(keyword));
      });
}
