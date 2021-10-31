import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesBloc bloc;
  late MockSearchTVSeries mockSearchTVSeries;
  String keyword = "The Simpsons";

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    bloc = SearchTVSeriesBloc(searchTVSeries: mockSearchTVSeries);
  });

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
      "should emit [SearchTVSeriesLoadingState, SearchResultTVSeriesLoadedState] when data is gotten successfully",
      build: () {
        when(mockSearchTVSeries.execute(keyword))
            .thenAnswer((_) async => Right([testWatchlistTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSearchResultTVSeriesEvent(keyword: keyword)),
      expect: () => [
            SearchTVSeriesLoadingState(),
            SearchResultTVSeriesLoadedState(),
          ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute(keyword));
      });

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
      "should emit [SearchTVSeriesLoadingState, LoadSearchTVSeriesFailureState] when get data is unsuccessful",
      build: () {
        when(mockSearchTVSeries.execute(keyword)).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Failure")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSearchResultTVSeriesEvent(keyword: keyword)),
      expect: () => [
            SearchTVSeriesLoadingState(),
            LoadSearchTVSeriesFailureState(message: "Server Failure"),
          ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute(keyword));
      });
}
