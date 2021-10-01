import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard(this.category);

  String get description {
    final lessonCount = category.lessons.length;
    var descriptionString = "$lessonCount Lesson";
    if (lessonCount > 1) descriptionString += "s";
    return descriptionString;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(14),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
