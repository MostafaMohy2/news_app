import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/core/models/articles_response.dart' hide Source;
import 'package:news_app/core/models/news_category.dart';
import 'package:news_app/core/models/sources_response.dart';
import 'package:news_app/core/utils/build_context_extensions.dart';
import 'package:news_app/core/utils/number_extensions.dart';
import 'package:news_app/core/utils/widget_extensions.dart';
import 'package:news_app/screens/home/widgets/article_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/app_assets.dart';

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
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: context.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                          ),
                          context: context,
                          builder: (context) =>
                              ArticleBottomShee(article: articles[index]),
                        );
                      },
                      child: ArticleCard(article: articles[index]),
                    ),
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

class ArticleBottomShee extends StatelessWidget {
  final Article article;
  const ArticleBottomShee({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SafeArea(
        child: Column(
          spacing: 16,
          mainAxisAlignment: .start,
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              placeholder: (_, _) => Image.asset(
                context.appConfig.isDarkMode
                    ? AppAssets.logoDark
                    : AppAssets.logoLight,
              ),
              errorWidget: (_, _, _) => Image.asset(
                context.appConfig.isDarkMode
                    ? AppAssets.logoDark
                    : AppAssets.logoLight,
              ),
              width: .infinity,
              height: 200,
              fit: .cover,
              imageBuilder: (_, imageProvider) =>
                  Image(image: imageProvider).clip(16),
            ),
            Expanded(
              child: Text(
                article.content ?? '',
                style: context.text.titleMedium!.copyWith(
                  color: context.colorScheme.onPrimary
                ),
                textAlign: .start,
              ),
            ),
            FilledButton(
              onPressed: () async {
                String rawUrl = article.url ?? '';
                rawUrl = rawUrl.replaceAll('https%3A', 'https://');
                await launchUrl(
                  Uri.parse(rawUrl),
                  mode: LaunchMode.externalApplication,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                minimumSize: Size(.infinity, 56),
              ),
              child: Text(
                'View Full Article',
                style: context.text.titleLarge!.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ],
        ).allPadding(16),
      ),
    );
  }
}
