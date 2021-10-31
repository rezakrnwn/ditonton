part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadTVSeriesDetailEvent extends TVSeriesDetailEvent {
  final int id;

  LoadTVSeriesDetailEvent({required this.id});
}

class AddTVSeriesWatchlistEvent extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  AddTVSeriesWatchlistEvent({
    required this.tvSeriesDetail,
  });
}

class RemoveTVSeriesWatchlistEvent extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  RemoveTVSeriesWatchlistEvent({
    required this.tvSeriesDetail,
  });
}