import 'package:acta/models/category.dart';
import 'package:acta/screens/at-base-screen.dart';
import 'package:acta/screens/news-by-category-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:acta/utils/navigation.dart';

class SearchByCategoryScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(id: 'business', name: 'Business', icon: Icon(MdiIcons.wallet)),
    Category(
        id: 'entertainment', name: 'Entertainment', icon: Icon(Icons.mood)),
    Category(id: 'general', name: 'General', icon: Icon(Icons.grade)),
    Category(id: 'health', name: 'Health', icon: Icon(MdiIcons.hospital)),
    Category(id: 'science', name: 'Science', icon: Icon(MdiIcons.mathSin)),
    Category(id: 'sports', name: 'Sports', icon: Icon(MdiIcons.soccer)),
    Category(id: 'technology', name: 'Technology', icon: Icon(Icons.computer))
  ];

  Widget _buildSearchByCategoryScreen() {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) =>
          _buildCategoryTile(context, categories[index]),
    );
  }

  Widget _buildCategoryTile(BuildContext context, Category category) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: category.icon,
          title: Text('${category.name}'),
          onTap: () => _navigateToNewsByCategory(context, category),
        ),
        Divider(),
      ],
    );
  }

  void _navigateToNewsByCategory(BuildContext context, Category category) {
    Navigation.navigateFromInside(
      context: context,
      screen: NewsByCategoryScreen(id: category.id, name: category.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Category',
      body: _buildSearchByCategoryScreen(),
      initialTab: 3,
    );
  }
}
