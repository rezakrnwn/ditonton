import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_series_event.dart';

part 'search_tv_series_state.dart';

class SearchTVSeriesBloc
    extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries _searchTVSeries;
  List<TVSeries> _result = [];

  List<TVSeries> get result => _result;

  SearchTVSeriesBloc({required SearchTVSeries searchTVSeries})
      : _searchTVSeries = searchTVSeries,
        super(SearchTVSeriesInitial()) {
    on<LoadSearchResultTVSeriesEvent>((event, emit) async {
      emit(SearchTVSeriesLoadingState());
      final result = await _searchTVSeries.execute(event.keyword);
      result.fold(
        (failure) => emit(LoadSearchTVSeriesFailureState(
          message: failure.message,
        )),
        (data) {
          _result = data;
          emit(SearchResultTVSeriesLoadedState());
        },
      );
    });
  }
}
