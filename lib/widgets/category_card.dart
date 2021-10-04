import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/pages/pages.dart';
import 'package:vocab_trainer/utils/description_generator.dart';

import 'menu_card.dart';

class CategoryCard extends StatelessWidget {

  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  void _navigateToCategory(BuildContext context) => Navigator.of(context)
      .pushNamed(CategoryScreen.routeName, arguments: category);

  @override
  Widget build(BuildContext context) {
    return MenuCard(
      title: category.title,
      description:
          DescriptionGenerator.generate(category.lessons.length, "Lesson"),
      navigate: _navigateToCategory,
    );
  }
}
