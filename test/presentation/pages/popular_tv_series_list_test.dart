import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakePopularTVSeriesEvent extends Fake implements PopularTVSeriesEvent {}

class FakePopularTVSeriesState extends Fake implements PopularTVSeriesState {}

class MockPopularTVSeriesBloc
    extends MockBloc<PopularTVSeriesEvent, PopularTVSeriesState>
    implements PopularTVSeriesBloc {}

void main() {
  late MockPopularTVSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue<PopularTVSeriesEvent>(FakePopularTVSeriesEvent());
    registerFallbackValue<PopularTVSeriesState>(FakePopularTVSeriesState());
  });

  setUp(() async {
    mockBloc = MockPopularTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('PopularTVSeriesList should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTVSeriesInitial());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesList()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('PopularTVSeriesList should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTVSeriesLoadedState());
    when(() => mockBloc.popularList).thenReturn([tvSeries]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesList()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('PopularTVSeriesList should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(LoadPopularTVSeriesFailureState(message: 'Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesList()));

    expect(textFinder, findsOneWidget);
  });
}
