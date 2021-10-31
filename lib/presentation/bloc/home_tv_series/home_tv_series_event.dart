part of 'home_tv_series_bloc.dart';

abstract class HomeTVSeriesEvent extends Equatable {
  const HomeTVSeriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeTVSeriesEvent extends HomeTVSeriesEvent {}
