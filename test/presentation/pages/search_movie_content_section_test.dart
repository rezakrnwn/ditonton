import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeSearchMovieEvent extends Fake implements SearchMovieEvent {}

class FakeSearchMovieState extends Fake implements SearchMovieState {}

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

void main() {
  late MockSearchMovieBloc mockBloc;

  setUpAll(() {
    registerFallbackValue<SearchMovieEvent>(FakeSearchMovieEvent());
    registerFallbackValue<SearchMovieState>(FakeSearchMovieState());
  });

  setUp(() async {
    mockBloc = MockSearchMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'SearchMovieContentSection should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchMovieLoadingState());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchMovieContentSection()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('SearchMovieContentSection should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchResultMovieLoadedState());
    when(() => mockBloc.result).thenReturn(testMovieList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchMovieContentSection()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'SearchMovieContentSection should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(LoadSearchMovieFailureState(message: 'Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SearchMovieContentSection()));

    expect(textFinder, findsOneWidget);
  });
}
