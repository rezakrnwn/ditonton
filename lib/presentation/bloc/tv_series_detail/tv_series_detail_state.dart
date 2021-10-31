part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailState extends Equatable {
  const TVSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TVSeriesDetailInitial extends TVSeriesDetailState {}

class TVSeriesDetailLoadingState extends TVSeriesDetailState {}

class TVSeriesDetailLoadedState extends TVSeriesDetailState {}

class SuccessAddOrRemoveWatchlistState extends TVSeriesDetailState {
  final String message;

  SuccessAddOrRemoveWatchlistState({
    this.message = "",
  });
}

class FailedAddOrRemoveWatchlistState extends TVSeriesDetailState {
  final String message;

  FailedAddOrRemoveWatchlistState({
    this.message = "",
  });
}

class LoadTVSeriesDetailFailureState extends TVSeriesDetailState {
  final String message;

  LoadTVSeriesDetailFailureState({
    this.message = "",
  });
}

class LoadTVSeriesRecommendationFailureState extends TVSeriesDetailState {
  final String message;

  LoadTVSeriesRecommendationFailureState({
    this.message = "",
  });
}