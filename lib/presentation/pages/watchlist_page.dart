import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const WatchlistPage(this.scaffoldKey);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<Widget> tabList = [
    Tab(
      child: Text(
        "Movie",
      ),
    ),
    Tab(
      child: Text(
        "TV Series",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ditonton - Watchlist"),
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
          ),
          bottom: TabBar(

            tabs: tabList,
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            WatchlistMoviesPage(),
            WatchlistTVSeriesPage(),
          ],
        ),
      ),
    );
  }
}
