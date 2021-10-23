import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final TVSeries tvSeries = TVSeries(
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

  test('should be a subclass of TV Series entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });
}
