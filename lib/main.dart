import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        accentColor: kMikadoYellow,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      //home: HomeMoviePage(),
      home: HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(
                builder: (_) => HomeMoviePage(
                    settings.arguments as GlobalKey<ScaffoldState>));
          case PopularMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
          case PopularTVSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
          case TopRatedMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
          case TopRatedTVSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
          case MovieDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(id: id),
              settings: settings,
            );
          case TVSeriesDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => TVSeriesDetailPage(id: id),
              settings: settings,
            );
          case SearchMoviePage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => SearchMoviePage());
          case SearchTVSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => SearchTVSeriesPage());
          case WatchlistMoviesPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
          case NowPlayingTVSeriesPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => NowPlayingTVSeriesPage());
          default:
            return MaterialPageRoute(builder: (_) {
              return Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
