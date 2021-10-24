import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVSeries])
void main() {
  late WatchlistTVSeriesBloc bloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    bloc =
        WatchlistTVSeriesBloc(getWatchlistTVSeries: mockGetWatchlistTVSeries);
  });

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      "should emit [WatchlistTVSeriesInitial, WatchlistTVSeriesLoadedState] when data is gotten successfully",
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistTVSeriesEvent()),
      expect: () => [
            WatchlistTVSeriesInitial(),
            WatchlistTVSeriesLoadedState(),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
      });

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      "should emit [WatchlistTVSeriesInitial, LoadWatchlistTVSeriesFailureState] when get data is unsuccessful",
      build: () {
        when(mockGetWatchlistTVSeries.execute()).thenAnswer(
            (realInvocation) async => Left(DatabaseFailure("Can't get data")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistTVSeriesEvent()),
      expect: () => [
            WatchlistTVSeriesInitial(),
            LoadWatchlistTVSeriesFailureState(message: "Can't get data"),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
      });
}
