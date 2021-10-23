import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesWatchListStatus {
  final TVSeriesRepository repository;

  GetTVSeriesWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
