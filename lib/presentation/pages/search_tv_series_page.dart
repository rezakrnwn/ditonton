import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv-series';
  final SearchTVSeriesBloc searchTVSeriesBloc = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: BlocProvider(
        create: (context) => searchTVSeriesBloc,
        child: SearchTVSeriesContentSection(),
      ),
    );
  }
}

class SearchTVSeriesContentSection extends StatefulWidget {
  const SearchTVSeriesContentSection({Key? key}) : super(key: key);

  @override
  _SearchTVSeriesContentSectionState createState() =>
      _SearchTVSeriesContentSectionState();
}

class _SearchTVSeriesContentSectionState
    extends State<SearchTVSeriesContentSection> {
  late SearchTVSeriesBloc searchTVSeriesBloc;

  @override
  void initState() {
    searchTVSeriesBloc = BlocProvider.of<SearchTVSeriesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            onSubmitted: (query) {
              searchTVSeriesBloc
                  .add(LoadSearchResultTVSeriesEvent(keyword: query));
            },
            decoration: InputDecoration(
              hintText: 'Search tv series title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Expanded(
            child: BlocBuilder(
              bloc: searchTVSeriesBloc,
              builder: (context, state) {
                if (state is SearchTVSeriesInitial) {
                  return Center(
                    child: Text("Search or type tv series"),
                  );
                } else if (state is SearchTVSeriesLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchResultTVSeriesLoadedState &&
                    searchTVSeriesBloc.result.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tvSeries = searchTVSeriesBloc.result[index];
                      return TVSeriesCard(
                        tvSeries,
                      );
                    },
                    itemCount: searchTVSeriesBloc.result.length,
                  );
                } else if (state is SearchResultTVSeriesLoadedState &&
                    searchTVSeriesBloc.result.isEmpty) {
                  return Center(
                    key: Key('empty_message'),
                    child: Text("Search not found"),
                  );
                } else {
                  String message = state is LoadSearchTVSeriesFailureState
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
        ],
      ),
    );
  }
}
