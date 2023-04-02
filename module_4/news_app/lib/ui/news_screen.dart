import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/article_detail_screen.dart';
import 'package:news_app/ui/news_bloc.dart';
import 'package:news_app/data/news_repository.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = kiwi.KiwiContainer().resolve<NewsBloc>();

    ///Add event to get articles.
    _newsBloc.add(GetArticles());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _newsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ArticleDetailScreen(article: article),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(article.title),
                        subtitle: Text(
                          article.content,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              );
            } else {
              return const Center(
                child: Text('Failed to get news, please retry'),
              );
            }
          },
        ),
      ),
    );
  }
}
