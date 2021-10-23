import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    useCase = SearchTVSeries(mockTVSeriesRepository);
  });

  final tvSeriesList = <TVSeries>[tvSeries];
  final query = 'The Simpsons';

  test(
      'should get list of tv series search result from the repository when execute function is called',
      () async {
    // arrange
    when(mockTVSeriesRepository.search(query))
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await useCase.execute(query);
    // assert
    expect(result, Right(tvSeriesList));
  });
}
