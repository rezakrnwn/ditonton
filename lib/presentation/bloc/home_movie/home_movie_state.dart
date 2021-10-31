part of 'home_movie_bloc.dart';

abstract class HomeMovieState extends Equatable {
  const HomeMovieState();

  @override
  List<Object> get props => [];
}

class HomeMovieInitial extends HomeMovieState {}

class HomeMovieLoadedState extends HomeMovieState {}

class LoadHomeMovieFailureState extends HomeMovieState {
  final String message;

  LoadHomeMovieFailureState({
    this.message = "",
  });
}
