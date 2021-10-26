import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeNowPlayingTVSeriesEvent extends Fake
    implements NowPlayingTVSeriesEvent {}

class FakeNowPlayingTVSeriesState extends Fake
    implements NowPlayingTVSeriesState {}

class MockNowPlayingTVSeriesBloc
    extends MockBloc<NowPlayingTVSeriesEvent, NowPlayingTVSeriesState>
    implements NowPlayingTVSeriesBloc {}

void main() {
  late MockNowPlayingTVSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue<NowPlayingTVSeriesEvent>(
        FakeNowPlayingTVSeriesEvent());
    registerFallbackValue<NowPlayingTVSeriesState>(
        FakeNowPlayingTVSeriesState());
  });

  setUp(() async {
    mockBloc = MockNowPlayingTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTVSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('NowPlayingTVSeriesList should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(NowPlayingTvSeriesInitial());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVSeriesList()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('NowPlayingTVSeriesList should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(NowPlayingTVSeriesLoadedState());
    when(() => mockBloc.nowPlayingList).thenReturn([tvSeries]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVSeriesList()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'NowPlayingTVSeriesList should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        LoadNowPlayingTVSeriesFailureState(message: 'Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVSeriesList()));

    expect(textFinder, findsOneWidget);
  });
}
