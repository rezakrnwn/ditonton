import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late NowPlayingTVSeriesBloc bloc;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    bloc = NowPlayingTVSeriesBloc(
        getNowPlayingTVSeries: mockGetNowPlayingTVSeries);
  });

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      "should emit [NowPlayingTvSeriesInitial, NowPlayingTVSeriesLoadedState] when data is gotten successfully",
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTVSeriesEvent()),
      expect: () => [
            NowPlayingTvSeriesInitial(),
            NowPlayingTVSeriesLoadedState(),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
      });

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      "should emit [NowPlayingTvSeriesInitial, LoadNowPlayingTVSeriesFailureState] when get data is unsuccessful",
      build: () {
        when(mockGetNowPlayingTVSeries.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Failure")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTVSeriesEvent()),
      expect: () => [
            NowPlayingTvSeriesInitial(),
            LoadNowPlayingTVSeriesFailureState(message: "Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
      });
}
