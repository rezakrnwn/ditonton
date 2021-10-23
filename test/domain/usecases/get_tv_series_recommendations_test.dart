import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesRecommendations useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    useCase = GetTVSeriesRecommendations(mockTVSeriesRepository);
  });

  final id = 1;
  final tvSeriesList = <TVSeries>[tvSeries];

  test(
      'should get list of tv series recommendations from the repository when execute function is called',
      () async {
    // arrange
    when(mockTVSeriesRepository.getRecommendations(id))
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await useCase.execute(id);
    // assert
    expect(result, Right(tvSeriesList));
  });
}
