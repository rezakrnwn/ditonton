part of 'home_tv_series_bloc.dart';

abstract class HomeTVSeriesState extends Equatable {
  const HomeTVSeriesState();

  @override
  List<Object> get props => [];
}

class HomeTVSeriesInitial extends HomeTVSeriesState {}

class HomeTVSeriesLoadedState extends HomeTVSeriesState {}

class LoadHomeTVSeriesFailureState extends HomeTVSeriesState {
  final String message;

  LoadHomeTVSeriesFailureState({
    this.message = "",
  });
}
