import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailResponse extends Equatable {
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<GenreModel> genres;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  NextEpisodeToAir? nextEpisodeToAir;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TVSeriesDetailResponse(
      {required this.backdropPath,
      required this.createdBy,
      required this.episodeRunTime,
      required this.firstAirDate,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.inProduction,
      required this.languages,
      required this.lastAirDate,
      required this.lastEpisodeToAir,
      required this.name,
      required this.nextEpisodeToAir,
      required this.networks,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.productionCompanies,
      required this.productionCountries,
      required this.seasons,
      required this.spokenLanguages,
      required this.status,
      required this.tagline,
      required this.type,
      required this.voteAverage,
      required this.voteCount});

  /*TVSeriesDetailResponse.fromJson(dynamic json) {
    backdropPath = json['backdrop_path'];
    if (json['created_by'] != null) {
      createdBy = [];
      json['created_by'].forEach((v) {
        createdBy?.add(CreatedBy.fromJson(v));
      });
    }
    episodeRunTime = json['episode_run_time'] != null ? json['episode_run_time'].cast<int>() : [];
    firstAirDate = json['first_air_date'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres.add(GenreModel.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = json['languages'] != null ? json['languages'].cast<String>() : [];
    lastAirDate = json['last_air_date'];
    lastEpisodeToAir = json['last_episode_to_air'] != null ? LastEpisodeToAir.fromJson(json['last_episode_to_air']) : null;
    name = json['name'];
    nextEpisodeToAir = json['next_episode_to_air'] != null ? NextEpisodeToAir.fromJson(json['next_episode_to_air']) : null;
    if (json['networks'] != null) {
      networks = [];
      json['networks'].forEach((v) {
        networks?.add(Networks.fromJson(v));
      });
    }
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = json['origin_country'] != null ? json['origin_country'].cast<String>() : [];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = [];
      json['production_companies'].forEach((v) {
        productionCompanies?.add(ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = [];
      json['production_countries'].forEach((v) {
        productionCountries?.add(ProductionCountries.fromJson(v));
      });
    }
    if (json['seasons'] != null) {
      seasons = [];
      json['seasons'].forEach((v) {
        seasons?.add(Seasons.fromJson(v));
      });
    }
    if (json['spoken_languages'] != null) {
      spokenLanguages = [];
      json['spoken_languages'].forEach((v) {
        spokenLanguages?.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }*/

  factory TVSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesDetailResponse(
        id: json['id'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'],
        posterPath: json['poster_path'],
        popularity: json['popularity'],
        overview: json['overview'],
        originCountry: json['origin_country'] != null
            ? json['origin_country'].cast<String>()
            : [],
        originalName: json['original_name'],
        originalLanguage: json['original_language'],
        firstAirDate: json['first_air_date'],
        backdropPath: json['backdrop_path'],
        name: json['name'],
        status: json['status'],
        createdBy: json['created_by'] != null
            ? List<CreatedBy>.from(
                json['created_by'].map((v) => CreatedBy.fromJson(v)))
            : [],
        episodeRunTime: json['episode_run_time'] != null
            ? json['episode_run_time'].cast<int>()
            : [],
        type: json['type'],
        tagline: json['tagline'],
        homepage: json['homepage'],
        inProduction: json['in_production'],
        languages:
            json['languages'] != null ? json['languages'].cast<String>() : [],
        lastAirDate: json['last_air_date'],
        lastEpisodeToAir: json['last_episode_to_air'] != null
            ? LastEpisodeToAir.fromJson(json['last_episode_to_air'])
            : null,
        networks: json['networks'] != null
            ? List<Networks>.from(
                json['networks'].map((v) => Networks.fromJson(v)))
            : [],
        nextEpisodeToAir: json['next_episode_to_air'] != null
            ? NextEpisodeToAir.fromJson(json['next_episode_to_air'])
            : null,
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        productionCompanies: json['production_companies'] != null
            ? List<ProductionCompanies>.from(json['production_companies']
                .map((v) => ProductionCompanies.fromJson(v)))
            : [],
        productionCountries: json['production_countries'] != null
            ? List<ProductionCountries>.from(json['production_countries']
                .map((v) => ProductionCountries.fromJson(v)))
            : [],
        seasons: json['seasons'] != null
            ? List<Seasons>.from(
                json['seasons'].map((v) => Seasons.fromJson(v)))
            : [],
        spokenLanguages: json['spoken_languages'] != null
            ? List<SpokenLanguages>.from(json['spoken_languages']
                .map((v) => SpokenLanguages.fromJson(v)))
            : [],
      );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['backdrop_path'] = backdropPath;
    if (createdBy != null) {
      map['created_by'] = createdBy?.map((v) => v.toJson()).toList();
    }
    map['episode_run_time'] = episodeRunTime;
    map['first_air_date'] = firstAirDate;
    if (genres != null) {
      map['genres'] = genres.map((v) => v.toJson()).toList();
    }
    map['homepage'] = homepage;
    map['id'] = id;
    map['in_production'] = inProduction;
    map['languages'] = languages;
    map['last_air_date'] = lastAirDate;
    if (lastEpisodeToAir != null) {
      map['last_episode_to_air'] = lastEpisodeToAir?.toJson();
    }
    map['name'] = name;
    map['next_episode_to_air'] = nextEpisodeToAir;
    if (networks != null) {
      map['networks'] = networks?.map((v) => v.toJson()).toList();
    }
    map['number_of_episodes'] = numberOfEpisodes;
    map['number_of_seasons'] = numberOfSeasons;
    map['origin_country'] = originCountry;
    map['original_language'] = originalLanguage;
    map['original_name'] = originalName;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    if (productionCompanies != null) {
      map['production_companies'] =
          productionCompanies?.map((v) => v.toJson()).toList();
    }
    if (productionCountries != null) {
      map['production_countries'] =
          productionCountries?.map((v) => v.toJson()).toList();
    }
    if (seasons != null) {
      map['seasons'] = seasons?.map((v) => v.toJson()).toList();
    }
    if (spokenLanguages != null) {
      map['spoken_languages'] =
          spokenLanguages?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['tagline'] = tagline;
    map['type'] = type;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originCountry: this.originCountry,
      firstAirDate: this.firstAirDate,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      name: this.name,
      popularity: this.popularity,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        originalName,
        backdropPath,
        genres,
        originCountry,
        firstAirDate,
        originalLanguage,
        originalName,
        popularity,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(dynamic json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['english_name'] = englishName;
    map['iso_639_1'] = iso6391;
    map['name'] = name;
    return map;
  }
}

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber});

  Seasons.fromJson(dynamic json) {
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['air_date'] = airDate;
    map['episode_count'] = episodeCount;
    map['id'] = id;
    map['name'] = name;
    map['overview'] = overview;
    map['poster_path'] = posterPath;
    map['season_number'] = seasonNumber;
    return map;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(dynamic json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    return map;
  }
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(dynamic json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['logo_path'] = logoPath;
    map['name'] = name;
    map['origin_country'] = originCountry;
    return map;
  }
}

class Networks {
  String? name;
  int? id;
  String? logoPath;
  String? originCountry;

  Networks({this.name, this.id, this.logoPath, this.originCountry});

  Networks.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    logoPath = json['logo_path'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['logo_path'] = logoPath;
    map['origin_country'] = originCountry;
    return map;
  }
}

class NextEpisodeToAir {
  String? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  NextEpisodeToAir(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  NextEpisodeToAir.fromJson(dynamic json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['air_date'] = airDate;
    map['episode_number'] = episodeNumber;
    map['id'] = id;
    map['name'] = name;
    map['overview'] = overview;
    map['production_code'] = productionCode;
    map['season_number'] = seasonNumber;
    map['still_path'] = stillPath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}

class LastEpisodeToAir {
  String? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  LastEpisodeToAir(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  LastEpisodeToAir.fromJson(dynamic json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['air_date'] = airDate;
    map['episode_number'] = episodeNumber;
    map['id'] = id;
    map['name'] = name;
    map['overview'] = overview;
    map['production_code'] = productionCode;
    map['season_number'] = seasonNumber;
    map['still_path'] = stillPath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}

class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  CreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  CreatedBy.fromJson(dynamic json) {
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    gender = json['gender'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['credit_id'] = creditId;
    map['name'] = name;
    map['gender'] = gender;
    map['profile_path'] = profilePath;
    return map;
  }
}
