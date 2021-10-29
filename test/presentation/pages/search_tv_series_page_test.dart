import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
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

  testWidgets('Page should display SearchTVSeriesContentSection when opened',
      (WidgetTester tester) async {
    final searchTVSeriesContentSectionFinder =
        find.byType(SearchTVSeriesContentSection);

    await tester.pumpWidget(_makeTestableWidget(SearchTVSeriesPage()));

    expect(searchTVSeriesContentSectionFinder, findsOneWidget);
  });
}
