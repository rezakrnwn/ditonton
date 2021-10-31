import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final HomeMovieBloc homeMovieBloc = locator();

  HomeMoviePage(this.globalKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton - Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
        leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.dehaze),
            onPressed: () {
              globalKey.currentState?.openDrawer();
            }),
      ),
      body: BlocProvider(
        create: (context) => homeMovieBloc,
        child: HomeMovieContentSection(),
      ),
    );
  }
}

class HomeMovieContentSection extends StatefulWidget {
  const HomeMovieContentSection({Key? key}) : super(key: key);

  @override
  _HomeMovieContentSectionState createState() =>
      _HomeMovieContentSectionState();
}

class _HomeMovieContentSectionState extends State<HomeMovieContentSection> {
  late HomeMovieBloc homeMovieBloc;

  @override
  void initState() {
    homeMovieBloc = BlocProvider.of<HomeMovieBloc>(context);
    homeMovieBloc.add(LoadHomeMovieEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: BlocBuilder(
        bloc: homeMovieBloc,
        builder: (context, state) {
          if (state is HomeMovieInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                  MovieList(homeMovieBloc.nowPlaying),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.pushNamed(
                        context, PopularMoviesPage.ROUTE_NAME),
                  ),
                  MovieList(homeMovieBloc.popular),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.pushNamed(
                        context, TopRatedMoviesPage.ROUTE_NAME),
                  ),
                  MovieList(homeMovieBloc.topRated),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
