part of 'search_tv_series_bloc.dart';

abstract class SearchTVSeriesEvent extends Equatable {
  const SearchTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchResultTVSeriesEvent extends SearchTVSeriesEvent {
  final String keyword;

  LoadSearchResultTVSeriesEvent({
    required this.keyword,
  });
}