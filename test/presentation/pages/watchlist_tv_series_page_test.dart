import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeWatchlistTVSeriesEvent extends Fake
    implements WatchlistTVSeriesEvent {}

class FakeWatchlistTVSeriesState extends Fake
    implements WatchlistTVSeriesState {}

class MockWatchlistTVSeriesBloc
    extends MockBloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}

void main() {
  late WatchlistTVSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue<WatchlistTVSeriesEvent>(FakeWatchlistTVSeriesEvent());
    registerFallbackValue<WatchlistTVSeriesState>(FakeWatchlistTVSeriesState());
  });

  setUp(() {
    mockBloc = MockWatchlistTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      WatchlistTVSeriesInitial(),
    );

    final centerFinder = find.byType(Center);
    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display data when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      WatchlistTVSeriesLoadedState(),
    );
    when(() => mockBloc.watchlist).thenReturn([testWatchlistTVSeries]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when data is empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      WatchlistTVSeriesLoadedState(),
    );
    when(() => mockBloc.watchlist).thenReturn([]);

    final textFinder = find.byKey(Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        LoadWatchlistTVSeriesFailureState(message: "Can't get data"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
