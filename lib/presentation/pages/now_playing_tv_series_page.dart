import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';
  final NowPlayingTVSeriesBloc nowPlayingTVSeriesBloc = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Series'),
      ),
      body: BlocProvider(
        create: (context) => nowPlayingTVSeriesBloc,
        child: NowPlayingTVSeriesList(),
      ),
    );
  }
}

class NowPlayingTVSeriesList extends StatefulWidget {
  @override
  _NowPlayingTVSeriesListState createState() => _NowPlayingTVSeriesListState();
}

class _NowPlayingTVSeriesListState extends State<NowPlayingTVSeriesList> {
  late NowPlayingTVSeriesBloc nowPlayingTVSeriesBloc;

  @override
  void initState() {
    nowPlayingTVSeriesBloc = BlocProvider.of<NowPlayingTVSeriesBloc>(context);
    nowPlayingTVSeriesBloc.add(LoadNowPlayingTVSeriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: BlocBuilder(
        bloc: nowPlayingTVSeriesBloc,
        builder: (context, state) {
          if (state is NowPlayingTvSeriesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTVSeriesLoadedState &&
              nowPlayingTVSeriesBloc.nowPlayingList.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = nowPlayingTVSeriesBloc.nowPlayingList[index];
                return TVSeriesCard(
                  tvSeries,
                );
              },
              itemCount: nowPlayingTVSeriesBloc.nowPlayingList.length,
            );
          } else if (state is NowPlayingTVSeriesLoadedState &&
              nowPlayingTVSeriesBloc.nowPlayingList.isEmpty) {
            return Center(
              key: Key('empty_message'),
              child: Text("Top rated tv series is empty"),
            );
          } else {
            String message = state is LoadNowPlayingTVSeriesFailureState
                ? state.message
                : "Error";
            return Center(
              key: Key('error_message'),
              child: Text(message),
            );
          }
        },
      ),
    );
  }
}
