import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTVSeriesBloc bloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    bloc = PopularTVSeriesBloc(getPopularTVSeries: mockGetPopularTVSeries);
  });

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      "should emit [PopularTVSeriesInitial, PopularTVSeriesLoadedState] when data is gotten successfully",
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPopularTVSeriesEvent()),
      expect: () => [
            PopularTVSeriesInitial(),
            PopularTVSeriesLoadedState(),
          ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      "should emit [PopularTVSeriesInitial, LoadPopularTVSeriesFailureState] when get data is unsuccessful",
      build: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Failure")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPopularTVSeriesEvent()),
      expect: () => [
            PopularTVSeriesInitial(),
            LoadPopularTVSeriesFailureState(message: "Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });
}
