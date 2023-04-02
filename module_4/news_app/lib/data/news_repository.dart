import 'package:flutter/material.dart';
import 'package:news_app/data/rest_api_service.dart';

import 'article.dart';

class NewsRepository {
  final RestApiService _restApiService;

  NewsRepository(this._restApiService);

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  Future<List<Article>> fetchNewArticles() async {
    _articles = await _restApiService.getArticles();
    if (_articles.isEmpty) throw NoArticleFoundException();
    return _articles;
  }
}

class NoArticleFoundException implements Exception {}
