import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/data/article.dart';
import 'package:news_app/data/news_repository.dart';
import 'package:news_app/data/rest_api_service.dart';

class MockRestApiService extends Mock implements RestApiService {}

void main() {
  late MockRestApiService mockRestApiService;

  ///System under test
  late NewsRepository sut;

  ///Test data
  final testArticles = [
    Article(title: 'Article 1', content: 'Article Content 1'),
    Article(title: 'Article 2', content: 'Article Content 2'),
    Article(title: 'Article 2', content: 'Article Content 3'),
  ];

  setUp(() {
    mockRestApiService = MockRestApiService();
    sut = NewsRepository(mockRestApiService);
  });

  group("initial values", () {
    test("articles are empty by default", () {
      expect(sut.articles, []);
    });
  });

  group("getArticles()", () {
    test("get a list of Articles from RestApiService.", () async {
      ///Arrange
      ///return testArticles if getArticles() is called.
      when(() => mockRestApiService.getArticles())
          .thenAnswer((_) async => testArticles);

      ///Act
      final articles = await sut.fetchNewArticles();

      ///Assert
      ///test getArticles() method is called once.
      verify(() => mockRestApiService.getArticles()).called(1);

      ///test if articles returned from fetchNewArticles() is similar to testArticles
      expect(articles, testArticles);

      ///test if _articles variable in NewsRepository is updated to testArticles.
      expect(sut.articles, testArticles);
    });

    test("Throw exception if list of articles is empty", () {
      ///Arrange
      when(() => mockRestApiService.getArticles()).thenAnswer((_) async => []);

      ///Assert
      expect(sut.fetchNewArticles(), throwsA(isA<NoArticleFoundException>()));
    });
  });
}
