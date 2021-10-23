import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesDetail useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    useCase = GetTVSeriesDetail(mockTVSeriesRepository);
  });

  final id = 1;

  test('should get tv series detail from the repository when execute function is called', () async {
    // arrange
    when(mockTVSeriesRepository.getDetail(id))
        .thenAnswer((_) async => Right(testTVSeriesDetail));
    // act
    final result = await useCase.execute(id);
    // assert
    expect(result, Right(testTVSeriesDetail));
  });
}
