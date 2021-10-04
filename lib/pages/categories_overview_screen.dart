import 'package:flutter/material.dart';
import 'package:vocab_trainer/data/dummy_data.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

class CategoriesOverviewScreen extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Categories",
        ),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (ctx, i) {
          final category = categories[i];
          return CategoryCard(key: ValueKey(category.id), category: category);
        },
        itemCount: categories.length,
      ),
    );
  }
}
