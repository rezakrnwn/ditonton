import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  int page;
  List<TVSeriesModel> results;
  int totalPages;
  int totalResults;

  TVSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TVSeriesResponse(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: json['results'] != null
          ? (json['results'] as List).map((v) => TVSeriesModel.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['page'] = page;
    map['results'] = results.map((v) => v.toJson()).toList();
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

  @override
  List<Object> get props => [page, totalPages, totalResults, results];
}
