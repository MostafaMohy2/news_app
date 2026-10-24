import 'package:flutter/material.dart';
import 'package:news_app/core/models/news_category.dart';
import 'package:news_app/core/utils/icons_extensions.dart';
import 'package:news_app/screens/home/tabs/home_tab.dart';

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
      drawer: Drawer(),
      body: selectedCategory == null
          ? HomeTab(
              onCategoryClick: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            )
          : const SizedBox(),
    );
  }
}
