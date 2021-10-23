import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource _tvSeriesRemoteDataSource;
  final TVSeriesLocalDataSource _tvSeriesLocalDataSource;

  TVSeriesRepositoryImpl({
    required TVSeriesRemoteDataSource tvSeriesRemoteDataSource,
    required TVSeriesLocalDataSource tvSeriesLocalDataSource,
  })  : _tvSeriesRemoteDataSource = tvSeriesRemoteDataSource,
        _tvSeriesLocalDataSource = tvSeriesLocalDataSource;

  @override
  Future<Either<Failure, List<TVSeries>>> getNowPlaying() async {
    try {
      final List<TVSeriesModel> result =
          await _tvSeriesRemoteDataSource.getNowPlaying();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TVSeriesDetail>> getDetail(int id) async {
    try {
      final result = await _tvSeriesRemoteDataSource.getDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopular() async {
    try {
      final result = await _tvSeriesRemoteDataSource.getPopular();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getRecommendations(int id) async {
    try {
      final result = await _tvSeriesRemoteDataSource.getRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRated() async {
    try {
      final result = await _tvSeriesRemoteDataSource.getTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getWatchlist() async {
    final result = await _tvSeriesLocalDataSource.getWatchlist();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await _tvSeriesLocalDataSource.getById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TVSeriesDetail tvSeries) async {
    try {
      final result =
          await _tvSeriesLocalDataSource.removeWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeries) async {
    try {
      final result =
          await _tvSeriesLocalDataSource.insertWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> search(String query) async {
    try {
      final result = await _tvSeriesRemoteDataSource.search(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
