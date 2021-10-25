import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';
  final TopRatedTVSeriesBloc topRatedTVSeriesBloc = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: BlocProvider(
        create: (context) => topRatedTVSeriesBloc,
        child: TopRatedTVSeriesList(),
      ),
    );
  }
}

class TopRatedTVSeriesList extends StatefulWidget {
  const TopRatedTVSeriesList({Key? key}) : super(key: key);

  @override
  _TopRatedTVSeriesListState createState() => _TopRatedTVSeriesListState();
}

class _TopRatedTVSeriesListState extends State<TopRatedTVSeriesList> {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;

  @override
  void initState() {
    topRatedTVSeriesBloc = BlocProvider.of<TopRatedTVSeriesBloc>(context);
    topRatedTVSeriesBloc.add(LoadTopRatedTVSeriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: BlocBuilder(
        bloc: topRatedTVSeriesBloc,
        builder: (context, state) {
          if (state is TopRatedTVSeriesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTVSeriesLoadedState &&
              topRatedTVSeriesBloc.topRatedList.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = topRatedTVSeriesBloc.topRatedList[index];
                return TVSeriesCard(
                  tvSeries,
                );
              },
              itemCount: topRatedTVSeriesBloc.topRatedList.length,
            );
          } else if (state is TopRatedTVSeriesLoadedState &&
              topRatedTVSeriesBloc.topRatedList.isEmpty) {
            return Center(
              key: Key('empty_message'),
              child: Text("Top rated tv series is empty"),
            );
          } else {
            String message = state is LoadTopRatedTVSeriesFailureState
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
