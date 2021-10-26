part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTVSeriesState extends Equatable {
  const NowPlayingTVSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesInitial extends NowPlayingTVSeriesState {}

class NowPlayingTVSeriesLoadedState extends NowPlayingTVSeriesState {}

class LoadNowPlayingTVSeriesFailureState extends NowPlayingTVSeriesState {
  final String message;

  LoadNowPlayingTVSeriesFailureState({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}
