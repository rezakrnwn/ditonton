import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/home_tv_series/home_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTVSeriesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final HomeTVSeriesBloc homeTVSeriesBloc = locator();

  HomeTVSeriesPage(this.globalKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton - TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVSeriesPage.ROUTE_NAME);
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
        create: (context) => homeTVSeriesBloc,
        child: HomeTVSeriesContentSection(),
      ),
    );
  }
}

class HomeTVSeriesContentSection extends StatefulWidget {
  const HomeTVSeriesContentSection({Key? key}) : super(key: key);

  @override
  _HomeTVSeriesContentSectionState createState() =>
      _HomeTVSeriesContentSectionState();
}

class _HomeTVSeriesContentSectionState
    extends State<HomeTVSeriesContentSection> {
  late HomeTVSeriesBloc homeTVSeriesBloc;

  @override
  void initState() {
    homeTVSeriesBloc = BlocProvider.of<HomeTVSeriesBloc>(context);
    homeTVSeriesBloc.add(LoadHomeTVSeriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: BlocBuilder(
        bloc: homeTVSeriesBloc,
        builder: (context, state) {
          if (state is HomeTVSeriesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubHeading(
                    title: 'Now Playing',
                    onTap: () => Navigator.pushNamed(
                        context, NowPlayingTVSeriesPage.ROUTE_NAME),
                  ),
                  TVSeriesList(homeTVSeriesBloc.nowPlaying),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.pushNamed(
                        context, PopularTVSeriesPage.ROUTE_NAME),
                  ),
                  TVSeriesList(homeTVSeriesBloc.popular),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.pushNamed(
                        context, TopRatedTVSeriesPage.ROUTE_NAME),
                  ),
                  TVSeriesList(homeTVSeriesBloc.topRated),
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

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeriesList;

  TVSeriesList(this.tvSeriesList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                  context, TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeries.id),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
