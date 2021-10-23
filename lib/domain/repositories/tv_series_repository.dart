import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getNowPlaying();

  Future<Either<Failure, List<TVSeries>>> getPopular();

  Future<Either<Failure, List<TVSeries>>> getTopRated();

  Future<Either<Failure, TVSeriesDetail>> getDetail(int id);

  Future<Either<Failure, List<TVSeries>>> getRecommendations(int id);

  Future<Either<Failure, List<TVSeries>>> search(String query);

  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeries);

  Future<Either<Failure, String>> removeWatchlist(TVSeriesDetail tvSeries);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TVSeries>>> getWatchlist();
}
