import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/utils/description_generator.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

import 'lesson_screen.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "/category";

  @override
  Widget build(BuildContext context) {
    final _category = ModalRoute.of(context)?.settings.arguments as Category;
    final _lessons = _category.lessons;
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.title),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: _lessons.length > 0
          ? CategoryLessonCollectionView(
              menuItems: _lessons
                  .map((lesson) => MenuItem(
                      id: lesson.id,
                      title: lesson.title,
                      description: DescriptionGenerator.generate(
                        lesson.filecards.length,
                        "Card",
                      ),
                      navigate: (ctx) => Navigator.of(ctx).pushNamed(
                            LessonScreen.routeName,
                            arguments: lesson,
                          )))
                  .toList())
          : Center(
              child: Text("No Lessons created yet."),
            ),
    );
  }
}
