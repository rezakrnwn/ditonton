import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp(() async {
    await GetIt.I.reset();
    await di.init();
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('Page should display PopularMovieList when opened',
      (WidgetTester tester) async {
    final popularMovieListFinder = find.byType(PopularMovieList);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(popularMovieListFinder, findsOneWidget);
  });
}
