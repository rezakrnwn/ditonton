import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  @override
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage> {
  late WatchlistTVSeriesBloc watchlistTVSeriesBloc;

  @override
  void initState() {
    watchlistTVSeriesBloc = BlocProvider.of<WatchlistTVSeriesBloc>(context);
    watchlistTVSeriesBloc.add(LoadWatchlistTVSeriesEvent());
    super.initState();
  }

  @override
  void dispose() {
    watchlistTVSeriesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          bloc: watchlistTVSeriesBloc,
          builder: (context, state) {
            if (state is WatchlistTVSeriesInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTVSeriesLoadedState &&
                watchlistTVSeriesBloc.watchlist.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = watchlistTVSeriesBloc.watchlist[index];
                  return TVSeriesCard(
                    tvSeries,
                    isFromWatchList: true,
                  );
                },
                itemCount: watchlistTVSeriesBloc.watchlist.length,
              );
            } else if (state is WatchlistTVSeriesLoadedState &&
                watchlistTVSeriesBloc.watchlist.isEmpty) {
              return Center(
                key: Key('empty_message'),
                child: Text("Watchlist tv series is empty"),
              );
            } else {
              String message = state is LoadWatchlistTVSeriesFailureState
                  ? state.message
                  : "Error";
              return Center(
                key: Key('error_message'),
                child: Text(message),
              );
            }
          },
        ),
      ),
    );
  }
}
