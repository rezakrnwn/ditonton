import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeSearchTVSeriesEvent extends Fake implements SearchTVSeriesEvent {}

class FakeSearchTVSeriesState extends Fake implements SearchTVSeriesState {}

class MockSearchTVSeriesBloc
    extends MockBloc<SearchTVSeriesEvent, SearchTVSeriesState>
    implements SearchTVSeriesBloc {}

void main() {
  late MockSearchTVSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue<SearchTVSeriesEvent>(FakeSearchTVSeriesEvent());
    registerFallbackValue<SearchTVSeriesState>(FakeSearchTVSeriesState());
  });

  setUp(() async {
    mockBloc = MockSearchTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTVSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'SearchTVSeriesContentSection should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTVSeriesLoadingState());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(SearchTVSeriesContentSection()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('SearchTVSeriesContentSection should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchResultTVSeriesLoadedState());
    when(() => mockBloc.result).thenReturn([tvSeries]);

    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(_makeTestableWidget(SearchTVSeriesContentSection()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'SearchTVSeriesContentSection should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(LoadSearchTVSeriesFailureState(message: 'Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester
        .pumpWidget(_makeTestableWidget(SearchTVSeriesContentSection()));

    expect(textFinder, findsOneWidget);
  });
}
