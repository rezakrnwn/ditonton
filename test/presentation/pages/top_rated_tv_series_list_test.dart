import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeTopRatedTVSeriesEvent extends Fake implements TopRatedTVSeriesEvent {}

class FakeTopRatedTVSeriesState extends Fake implements TopRatedTVSeriesState {}

class MockTopRatedTVSeriesBloc
    extends MockBloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState>
    implements TopRatedTVSeriesBloc {}

void main() {
  late MockTopRatedTVSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue<TopRatedTVSeriesEvent>(FakeTopRatedTVSeriesEvent());
    registerFallbackValue<TopRatedTVSeriesState>(FakeTopRatedTVSeriesState());
  });

  setUp(() async {
    mockBloc = MockTopRatedTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('TopRatedTVSeriesList should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTVSeriesInitial());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesList()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('TopRatedTVSeriesList should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTVSeriesLoadedState());
    when(() => mockBloc.topRatedList).thenReturn([tvSeries]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesList()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'TopRatedTVSeriesList should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        LoadTopRatedTVSeriesFailureState(message: 'Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesList()));

    expect(textFinder, findsOneWidget);
  });
}
