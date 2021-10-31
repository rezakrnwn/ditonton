import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/detail-tv-series';
  final int id;
  final TvSeriesDetailBloc tvSeriesDetailBloc = locator();

  TVSeriesDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => tvSeriesDetailBloc,
          child: TVSeriesDetailContentSection(
            id: id,
          ),
        ),
      ),
    );
  }
}

class TVSeriesDetailContentSection extends StatefulWidget {
  final int id;

  const TVSeriesDetailContentSection({
    required this.id,
  });

  @override
  _TVSeriesDetailContentSectionState createState() =>
      _TVSeriesDetailContentSectionState();
}

class _TVSeriesDetailContentSectionState
    extends State<TVSeriesDetailContentSection> {
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  @override
  void initState() {
    tvSeriesDetailBloc = BlocProvider.of<TvSeriesDetailBloc>(context);
    tvSeriesDetailBloc.add(LoadTVSeriesDetailEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: tvSeriesDetailBloc,
      listener: (context, state) {
        if (state is SuccessAddOrRemoveWatchlistState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: Duration(seconds: 2),
          ));
        } else if (state is FailedAddOrRemoveWatchlistState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: Duration(seconds: 2),
          ));
        }
      },
      child: BlocBuilder(
          bloc: tvSeriesDetailBloc,
          builder: (context, state) {
            if (state is TVSeriesDetailInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${tvSeriesDetailBloc.tvSeriesDetail.posterPath}',
                    width: screenWidth,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: kRichBlack,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tvSeriesDetailBloc
                                                .tvSeriesDetail.name ??
                                            "-",
                                        style: kHeading5,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (!tvSeriesDetailBloc
                                              .isAddedToWatchlist) {
                                            tvSeriesDetailBloc.add(
                                                AddTVSeriesWatchlistEvent(
                                                    tvSeriesDetail:
                                                        tvSeriesDetailBloc
                                                            .tvSeriesDetail));
                                          } else {
                                            tvSeriesDetailBloc.add(
                                                RemoveTVSeriesWatchlistEvent(
                                                    tvSeriesDetail:
                                                        tvSeriesDetailBloc
                                                            .tvSeriesDetail));
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            tvSeriesDetailBloc
                                                    .isAddedToWatchlist
                                                ? Icon(Icons.check)
                                                : Icon(Icons.add),
                                            Text('Watchlist'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        tvSeriesDetailBloc.genres,
                                      ),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: tvSeriesDetailBloc
                                                    .tvSeriesDetail
                                                    .voteAverage ??
                                                0 / 2,
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: kMikadoYellow,
                                            ),
                                            itemSize: 24,
                                          ),
                                          Text(
                                              '${tvSeriesDetailBloc.tvSeriesDetail.voteAverage}')
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Overview',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        tvSeriesDetailBloc
                                                .tvSeriesDetail.overview ??
                                            "-",
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Recommendations',
                                        style: kHeading6,
                                      ),
                                      Visibility(
                                        visible: tvSeriesDetailBloc
                                            .tvSeriesRecommendations.isNotEmpty,
                                        child: Container(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final tvSeries = tvSeriesDetailBloc
                                                      .tvSeriesRecommendations[
                                                  index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      TVSeriesDetailPage
                                                          .ROUTE_NAME,
                                                      arguments: tvSeries.id,
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: tvSeriesDetailBloc
                                                .tvSeriesRecommendations.length,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: tvSeriesDetailBloc
                                            .tvSeriesRecommendations.isEmpty,
                                        child: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                            top: 20,
                                          ),
                                          child: Text(
                                              "No tv series recommendation found"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // initialChildSize: 0.5,
                      minChildSize: 0.25,
                      // maxChildSize: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: kRichBlack,
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
