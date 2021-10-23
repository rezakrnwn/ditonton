import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  String? backdropPath;
  List<int>? genreIds;
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

  TVSeries({
    required this.name,
    required this.backdropPath,
    required this.genreIds,
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

  TVSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
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
