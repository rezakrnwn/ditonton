import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;
  late TVSeriesRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockTVSeriesRemoteDataSource();
    mockLocalDataSource = MockTVSeriesLocalDataSource();
    repository = TVSeriesRepositoryImpl(
      tvSeriesRemoteDataSource: mockRemoteDataSource,
      tvSeriesLocalDataSource: mockLocalDataSource,
    );
  });

  final TVSeriesModel tvSeriesModel = TVSeriesModel(
    name: "The Simpsons",
    backdropPath: "/adZ9ldSlkGfLfsHNbh37ZThCcgU.jpg",
    firstAirDate: "1989-12-17",
    genreIds: [
      10751,
      16,
      35,
    ],
    id: 456,
    originalLanguage: "en",
    originalName: "The Simpsons",
    originCountry: ["US"],
    overview:
        "Set in Springfield, the average American town, the show focuses on the antics and everyday adventures of the Simpson family; Homer, Marge, Bart, Lisa and Maggie, as well as a virtual cast of thousands. Since the beginning, the series has been a pop culture icon, attracting hundreds of celebrities to guest star. The show has also made name for itself in its fearless satirical take on politics, media and American life in general.",
    popularity: 455.358,
    posterPath: "/tubgEpjTUA7t0kejVMBsNBZDarZ.jpg",
    voteAverage: 7.9,
    voteCount: 7142,
  );

  final List<TVSeriesModel> tvSeriesModelList = [tvSeriesModel];
  final List<TVSeries> tvSeriesList = [tvSeries];

  group('Now Playing TV Series', () {
    test(
        'should return data from network when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular())
          .thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getPopular();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular()).thenThrow(ServerException());
      // act
      final result = await repository.getPopular();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopular();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated())
          .thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getTopRated();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRated();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRated();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('TV Series Recommendations', () {
    final id = 1;

    test('should return tv series list when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getRecommendations(id))
          .thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getRecommendations(id);
      // assert
      verify(mockRemoteDataSource.getRecommendations(id));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendations(id))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendations(id);
      // assertbuild runner
      verify(mockRemoteDataSource.getRecommendations(id));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendations(id))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendations(id);
      // assert
      verify(mockRemoteDataSource.getRecommendations(id));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV Series', () {
    final query = 'avengers';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(query))
          .thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.search(query);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(query)).thenThrow(ServerException());
      // act
      final result = await repository.search(query);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.search(query))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.search(query);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('TV Series Detail', () {
    final id = 1;
    final tvSeriesDetailResponse = TVSeriesDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 76.425,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      name: 'Avengers Assemble',
      voteAverage: 1,
      voteCount: 1,
      originCountry: ["en"],
      spokenLanguages: [],
      seasons: [],
      productionCountries: [],
      productionCompanies: [],
      numberOfSeasons: 2,
      numberOfEpisodes: 12,
      nextEpisodeToAir: NextEpisodeToAir(name: "Best Episode"),
      networks: [],
      lastAirDate: "2012-12-12",
      languages: [],
      originalName: "Avengers Assemble",
      inProduction: true,
      type: "x",
      firstAirDate: "2013-05-26",
      episodeRunTime: [],
      createdBy: [],
      lastEpisodeToAir: LastEpisodeToAir(name: "Last Episode"),
    );

    test(
        'should return TV Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(id))
          .thenAnswer((_) async => tvSeriesDetailResponse);
      // act
      final result = await repository.getDetail(id);
      // assert
      verify(mockRemoteDataSource.getDetail(id));
      expect(result, equals(Right(testTVSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(id)).thenThrow(ServerException());
      // act
      final result = await repository.getDetail(id);
      // assert
      verify(mockRemoteDataSource.getDetail(id));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(id))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetail(id);
      // assert
      verify(mockRemoteDataSource.getDetail(id));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Save WatchList', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove WatchList', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get WatchList Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final id = 1;
      when(mockLocalDataSource.getById(id))
          .thenAnswer((_) async => testTVSeriesTable);
      // act
      final result = await repository.isAddedToWatchlist(id);
      // assert
      expect(result, true);
    });
  });

  group('Get WatchList TV Series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [testTVSeriesTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTVSeries]);
    });
  });
}
