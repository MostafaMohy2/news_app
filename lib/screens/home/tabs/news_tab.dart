import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/core/models/articles_response.dart' hide Source;
import 'package:news_app/core/models/news_category.dart';
import 'package:news_app/core/models/sources_response.dart';
import 'package:news_app/core/utils/build_context_extensions.dart';
import 'package:news_app/core/utils/number_extensions.dart';
import 'package:news_app/core/utils/widget_extensions.dart';
import 'package:news_app/screens/home/widgets/article_card.dart';

class NewsTab extends StatelessWidget {
  final NewsCategory category;
  final ApiManager apiManager = ApiManager();
  NewsTab({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourcesResponse>(
      future: ApiManager().getSources(category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          if (snapshot.data?.message != null) {
            return Center(child: Text(snapshot.data!.message!));
          } else {
            final sources = snapshot.data?.sources ?? [];
            return NewsLayout(sources: sources);
          }
        }
      },
    );
  }
}

class NewsLayout extends StatefulWidget {
  const NewsLayout({required this.sources, super.key});

  final List<Source> sources;

  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: widget.sources.length,
          child: TabBar(
            isScrollable: true,
            tabAlignment: .start,
            dividerHeight: 0,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            tabs: widget.sources
                .map(
                  (e) => Text(
                    e.name ?? '',
                    style: context.text.labelLarge,
                  ).allPadding(16),
                )
                .toList(),
          ),
        ),
        16.verticalSpace,
        Expanded(
          child: FutureBuilder<ArticlesResponse>(
            future: ApiManager().getArticles(
              widget.sources[selectedIndex].id ?? '',
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == .waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                if (snapshot.data?.message != null) {
                  return Center(child: Text(snapshot.data!.message!));
                } else {
                  final articles = snapshot.data?.articles ?? [];
                  return ListView.separated(
                    separatorBuilder: (_, _) => 16.verticalSpace,
                    padding: EdgeInsets.all(16),
                    itemCount: articles.length,
                    itemBuilder: (context, index) =>
                        ArticleCard(article: articles[index]),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
