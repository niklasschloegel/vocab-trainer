import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/lesson.dart';
import 'package:vocab_trainer/utils/description_generator.dart';
import 'package:vocab_trainer/widgets/menu_card.dart';

class LessonCard extends StatelessWidget {
  
  final Lesson lesson;
  const LessonCard({Key? key, required this.lesson}) : super(key: key);

  void _navigateToLesson(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return MenuCard(
      key: ValueKey(lesson.id),
      title: lesson.title,
      description: DescriptionGenerator.generate(lesson.filecards.length, "Card"),
      navigate: _navigateToLesson,
    );
  }
}
