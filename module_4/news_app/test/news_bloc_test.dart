import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/data/article.dart';
import 'package:news_app/data/news_repository.dart';
import 'package:news_app/ui/news_bloc.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  ///System under test
  late NewsBloc sut;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    sut = NewsBloc(mockNewsRepository);
  });

  tearDown(() => sut.close());

  ///Test data
  final testArticles = [
    Article(title: 'Article 1', content: 'Article Content 1'),
    Article(title: 'Article 2', content: 'Article Content 2'),
    Article(title: 'Article 2', content: 'Article Content 3'),
  ];

  group("Initial states and values", () {
    blocTest<NewsBloc, NewsState>(
      "Initial state should be loading",
      build: () => sut,
      verify: (bloc) => expect(bloc.state, NewsLoading()),
    );
  });

  group("_onGetArticles()", () {
    blocTest<NewsBloc, NewsState>(
        "Bloc should emit NewsLoaded on fetch success.",
        setUp: () {
          when(() => mockNewsRepository.fetchNewArticles())
              .thenAnswer((_) async => testArticles);
        },
        build: () => sut,
        act: (bloc) => bloc.add(GetArticles()),
        expect: () => <NewsState>[NewsLoaded(testArticles)],
        verify: (_) {
          verify(() => mockNewsRepository.fetchNewArticles()).called(1);
        });

    blocTest<NewsBloc, NewsState>(
        "Bloc should emit NewsLoadFailed on exception.",
        setUp: () {
          when(() => mockNewsRepository.fetchNewArticles())
              .thenThrow(NoArticleFoundException());
        },
        build: () => sut,
        act: (bloc) => bloc.add(GetArticles()),
        expect: () => <NewsState>[NewsLoadFailed()],
        verify: (_) {
          verify(() => mockNewsRepository.fetchNewArticles()).called(1);
        });
  });
}
