import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  String? backdropPath;
  final List<Genre> genres;
  int id;
  String? name;
  String? originalName;
  String? originalLanguage;
  List<String>? originCountry;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;

  TVSeriesDetail({
    required this.name,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originalLanguage,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        originalLanguage,
        originCountry,
      ];
}
