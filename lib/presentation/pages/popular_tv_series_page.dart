import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tv-series';
  final PopularTVSeriesBloc popularTVSeriesBloc = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: BlocProvider(
        create: (context) => popularTVSeriesBloc,
        child: PopularTVSeriesList(),
      ),
    );
  }
}

class PopularTVSeriesList extends StatefulWidget {
  const PopularTVSeriesList({Key? key}) : super(key: key);

  @override
  _PopularTVSeriesListState createState() => _PopularTVSeriesListState();
}

class _PopularTVSeriesListState extends State<PopularTVSeriesList> {
  late PopularTVSeriesBloc popularTVSeriesBloc;

  @override
  void initState() {
    popularTVSeriesBloc = BlocProvider.of<PopularTVSeriesBloc>(context);
    popularTVSeriesBloc.add(LoadPopularTVSeriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: BlocBuilder(
        bloc: popularTVSeriesBloc,
        builder: (context, state) {
          if (state is PopularTVSeriesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTVSeriesLoadedState &&
              popularTVSeriesBloc.popularList.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = popularTVSeriesBloc.popularList[index];
                return TVSeriesCard(
                  tvSeries,
                );
              },
              itemCount: popularTVSeriesBloc.popularList.length,
            );
          } else if (state is PopularTVSeriesLoadedState &&
              popularTVSeriesBloc.popularList.isEmpty) {
            return Center(
              key: Key('empty_message'),
              child: Text("Top rated tv series is empty"),
            );
          } else {
            String message = state is LoadPopularTVSeriesFailureState
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
