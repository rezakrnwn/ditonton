import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_series_event.dart';

part 'now_playing_tv_series_state.dart';

class NowPlayingTVSeriesBloc
    extends Bloc<NowPlayingTVSeriesEvent, NowPlayingTVSeriesState> {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;
  List<TVSeries> _nowPlayingList = [];

  List<TVSeries> get nowPlayingList => _nowPlayingList;

  NowPlayingTVSeriesBloc({required GetNowPlayingTVSeries getNowPlayingTVSeries})
      : _getNowPlayingTVSeries = getNowPlayingTVSeries,
        super(NowPlayingTvSeriesInitial()) {
    on<LoadNowPlayingTVSeriesEvent>((event, emit) async {
      emit(NowPlayingTvSeriesInitial());
      final result = await _getNowPlayingTVSeries.execute();
      result.fold(
        (failure) => emit(LoadNowPlayingTVSeriesFailureState(
          message: failure.message,
        )),
        (data) {
          _nowPlayingList = data;
          emit(NowPlayingTVSeriesLoadedState());
        },
      );
    });
  }
}
