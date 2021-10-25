import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;
  List<TVSeries> _topRatedList = [];

  List<TVSeries> get topRatedList => _topRatedList;

  TopRatedTVSeriesBloc({
    required GetTopRatedTVSeries getTopRatedTVSeries,
  })  : _getTopRatedTVSeries = getTopRatedTVSeries,
        super(TopRatedTVSeriesInitial()) {
    on<LoadTopRatedTVSeriesEvent>((event, emit) async {
      emit(TopRatedTVSeriesInitial());
      final result = await _getTopRatedTVSeries.execute();
      result.fold(
        (failure) => emit(LoadTopRatedTVSeriesFailureState(
          message: failure.message,
        )),
        (data) {
          _topRatedList = data;
          emit(TopRatedTVSeriesLoadedState());
        },
      );
    });
  }
}
