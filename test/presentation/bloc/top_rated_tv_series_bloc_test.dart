import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTVSeriesBloc bloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    bloc = TopRatedTVSeriesBloc(getTopRatedTVSeries: mockGetTopRatedTVSeries);
  });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      "should emit [TopRatedTVSeriesInitial, TopRatedTVSeriesLoadedState] when data is gotten successfully",
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTVSeriesEvent()),
      expect: () => [
            TopRatedTVSeriesInitial(),
            TopRatedTVSeriesLoadedState(),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      "should emit [TopRatedTVSeriesInitial, LoadTopRatedTVSeriesFailureState] when get data is unsuccessful",
      build: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Failure")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTVSeriesEvent()),
      expect: () => [
            TopRatedTVSeriesInitial(),
            LoadTopRatedTVSeriesFailureState(message: "Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });
}
