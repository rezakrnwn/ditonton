import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  TVSeriesModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TVSeriesModel.fromJson(dynamic json) => TVSeriesModel(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'],
        genreIds:
            json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [],
        id: json['id'],
        name: json['name'],
        originCountry: json['origin_country'] != null
            ? json['origin_country'].cast<String>()
            : [],
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        voteAverage: double.parse(json['vote_average'].toString()),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['backdrop_path'] = backdropPath;
    map['first_air_date'] = firstAirDate;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['name'] = name;
    map['origin_country'] = originCountry;
    map['original_language'] = originalLanguage;
    map['original_name'] = originalName;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

  TVSeries toEntity() {
    return TVSeries(
      name: this.name,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalName,
      originalLanguage: this.originalLanguage,
      firstAirDate: this.firstAirDate,
      originCountry: this.originCountry,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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
