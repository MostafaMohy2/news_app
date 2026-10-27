import 'package:flutter/material.dart';
import 'package:news_app/core/models/news_category.dart';
import 'package:news_app/core/utils/build_context_extensions.dart';
import 'package:news_app/core/utils/icons_extensions.dart';
import 'package:news_app/screens/home/tabs/home_tab.dart';
import 'package:news_app/screens/home/tabs/news_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icons.search_rounded.toIcon),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextButton(
              onPressed: () {
                selectedCategory = null;
                context.pop();
                setState(() {});
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
      body: selectedCategory == null
          ? HomeTab(onCategoryClick: (category) => changeCategory(category))
          : NewsTab(category: selectedCategory!),
    );
  }

  void changeCategory(NewsCategory category) {
    selectedCategory = category;
    setState(() {});
  }
}
