part of 'watchlist_tv_series_bloc.dart';

@immutable
abstract class WatchlistTVSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistTVSeriesInitial extends WatchlistTVSeriesState {}

class WatchlistTVSeriesLoadedState extends WatchlistTVSeriesState {}

class LoadWatchlistTVSeriesFailureState extends WatchlistTVSeriesState {
  final String message;

  LoadWatchlistTVSeriesFailureState({
    this.message = "",
  });

  @override
  List<Object?> get props => [message];
}
