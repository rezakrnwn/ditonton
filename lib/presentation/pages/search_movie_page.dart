import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviePage extends StatelessWidget {
  static const ROUTE_NAME = '/search-movie';
  final SearchMovieBloc searchMovieBloc = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movie'),
      ),
      body: BlocProvider(
        create: (context) => searchMovieBloc,
        child: SearchMovieContentSection(),
      ),
    );
  }
}

class SearchMovieContentSection extends StatefulWidget {
  const SearchMovieContentSection({Key? key}) : super(key: key);

  @override
  _SearchMovieContentSectionState createState() =>
      _SearchMovieContentSectionState();
}

class _SearchMovieContentSectionState extends State<SearchMovieContentSection> {
  late SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    searchMovieBloc = BlocProvider.of<SearchMovieBloc>(context);
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
              searchMovieBloc.add(LoadSearchResultMovieEvent(keyword: query));
            },
            decoration: InputDecoration(
              hintText: 'Search movie title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Expanded(
            child: BlocBuilder(
              bloc: searchMovieBloc,
              builder: (context, state) {
                if (state is SearchMovieInitial) {
                  return Center(
                    child: Text("Search or type movie"),
                  );
                } else if (state is SearchMovieLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchResultMovieLoadedState &&
                    searchMovieBloc.result.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = searchMovieBloc.result[index];
                      return MovieCard(
                        movie,
                      );
                    },
                    itemCount: searchMovieBloc.result.length,
                  );
                } else if (state is SearchResultMovieLoadedState &&
                    searchMovieBloc.result.isEmpty) {
                  return Center(
                    key: Key('empty_message'),
                    child: Text("Search not found"),
                  );
                } else {
                  String message = state is LoadSearchMovieFailureState
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
