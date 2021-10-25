import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp(() async {
    await GetIt.I.reset();
    di.init();
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('Page should display PopularTVSeriesList when opened',
      (WidgetTester tester) async {
    final popularTVSeriesListFinder = find.byType(PopularTVSeriesList);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(popularTVSeriesListFinder, findsOneWidget);
  });
}
