import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVSeries useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    useCase = GetPopularTVSeries(mockTVSeriesRepository);
  });

  final tvSeriesList = <TVSeries>[tvSeries];

  test(
      'should get list of popular tv series from the repository when execute function is called',
      () async {
    // arrange
    when(mockTVSeriesRepository.getPopular())
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tvSeriesList));
  });
}
