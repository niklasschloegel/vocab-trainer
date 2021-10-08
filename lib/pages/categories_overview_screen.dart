import 'package:flutter/material.dart';
import 'package:vocab_trainer/data/dummy_data.dart';
import 'package:vocab_trainer/utils/description_generator.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

import 'category_screen.dart';

class CategoriesOverviewScreen extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: false,
        title: Text(
          "Categories",
        ),
      ),
      body: categories.length > 0
          ? CategoryLessonCollectionView(
              menuItems: categories
                  .map((category) => MenuItem(
                      id: category.id,
                      title: category.title,
                      description: DescriptionGenerator.generate(
                        category.lessons.length,
                        "Lesson",
                      ),
                      navigate: (ctx) => Navigator.of(ctx).pushNamed(
                            CategoryScreen.routeName,
                            arguments: category,
                          )))
                  .toList())
          : Center(child: Text("No Categories created yet.")),
    );
  }
}
