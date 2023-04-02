import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/article.dart';
import '../data/news_repository.dart';

///Event
abstract class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object?> get props => [];
}

class GetArticles extends NewsEvent {}

///State
abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  const NewsLoaded(this.articles);
  @override
  List<Object?> get props => [articles];
}

class NewsLoadFailed extends NewsState {}

///Bloc
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository) : super(NewsLoading()) {
    on<GetArticles>(_onGetArticles);
  }

  void _onGetArticles(GetArticles event, Emitter<NewsState> emit) async {
    try {
      final articles = await _newsRepository.fetchNewArticles();
      emit(NewsLoaded(articles));
    } on NoArticleFoundException catch (_) {
      emit(NewsLoadFailed());
    }
  }
}
