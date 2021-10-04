import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "/category";

  @override
  Widget build(BuildContext context) {
    final _category = ModalRoute.of(context)?.settings.arguments as Category;
    final _lessons = _category.lessons;
    return Scaffold(
        appBar: AppBar(title: Text(_category.title)),
        body: _lessons.length > 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (ctx, i) {
                  final lesson = _lessons[i];
                  return LessonCard(key: ValueKey(lesson.id), lesson: lesson);
                },
                itemCount: _category.lessons.length,
              )
            : Center(child: Text("No Lessons created yet.")));
  }
}
