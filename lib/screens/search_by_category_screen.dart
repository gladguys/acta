import 'package:acta/i18n/app_localizations.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/category.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:acta/screens/news_by_category_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchByCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchByCategoryScreenState();
}

class _SearchByCategoryScreenState extends State<SearchByCategoryScreen> {
  List<Category> categories;

  @override
  Widget build(BuildContext context) {
    initCategories();
    return ATBaseScreen(
      title: ATLabels.ACTA,
      subtitle: AppLocalizations.of(context).category,
      body: _buildSearchByCategoryScreen(),
      initialTab: 2,
    );
  }

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

  void initCategories() {
    categories = [
      Category(
          id: 'business',
          name: AppLocalizations.of(context).business,
          icon: Icon(MdiIcons.wallet)),
      Category(
          id: 'entertainment',
          name: AppLocalizations.of(context).entertainment,
          icon: Icon(Icons.mood)),
      Category(
          id: 'general',
          name: AppLocalizations.of(context).general,
          icon: Icon(Icons.grade)),
      Category(
          id: 'health',
          name: AppLocalizations.of(context).health,
          icon: Icon(MdiIcons.hospital)),
      Category(
          id: 'science',
          name: AppLocalizations.of(context).science,
          icon: Icon(MdiIcons.mathSin)),
      Category(
          id: 'sports',
          name: AppLocalizations.of(context).sports,
          icon: Icon(MdiIcons.soccer)),
      Category(
          id: 'technology',
          name: AppLocalizations.of(context).technology,
          icon: Icon(Icons.computer))
    ];
  }
}
