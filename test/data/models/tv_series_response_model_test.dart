import 'dart:convert';

import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
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

  final tvSeriesResponseModel =
      TVSeriesResponse(page: 1, totalPages: 1, totalResults: 1, results: <TVSeriesModel>[tvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_now_playing.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "total_pages": 1,
        "total_results": 1,
        "results": [
          {
            "backdrop_path": "/adZ9ldSlkGfLfsHNbh37ZThCcgU.jpg",
            "first_air_date": "1989-12-17",
            "genre_ids": [
              10751,
              16,
              35
            ],
            "id": 456,
            "name": "The Simpsons",
            "origin_country": [
              "US"
            ],
            "original_language": "en",
            "original_name": "The Simpsons",
            "overview": "Set in Springfield, the average American town, the show focuses on the antics and everyday adventures of the Simpson family; Homer, Marge, Bart, Lisa and Maggie, as well as a virtual cast of thousands. Since the beginning, the series has been a pop culture icon, attracting hundreds of celebrities to guest star. The show has also made name for itself in its fearless satirical take on politics, media and American life in general.",
            "popularity": 455.358,
            "poster_path": "/tubgEpjTUA7t0kejVMBsNBZDarZ.jpg",
            "vote_average": 7.9,
            "vote_count": 7142
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
