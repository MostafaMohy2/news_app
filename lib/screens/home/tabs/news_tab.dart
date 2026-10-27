import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/core/models/news_category.dart';
import 'package:news_app/core/models/sources_response.dart';

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
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          if (snapshot.data?.message != null) {
            return Center(child: Text(snapshot.data!.message!));
          } else {
            final sources = snapshot.data?.sources ?? [];
            return ListView.builder(
              itemBuilder: (context, index) => Text(sources[index].name ?? ''),
            );
          }
        }
      },
    );
  }
}
