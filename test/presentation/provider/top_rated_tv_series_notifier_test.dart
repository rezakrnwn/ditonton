import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TopRatedTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    notifier =
        TopRatedTVSeriesNotifier(getTopRatedTVSeries: mockGetTopRatedTVSeries)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final List<TVSeries> tvSeriesList = [tvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    notifier.fetchTopRated();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change TV Series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    await notifier.fetchTopRated();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRated();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
