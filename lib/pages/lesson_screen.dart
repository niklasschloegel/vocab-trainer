import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

class LessonScreen extends StatelessWidget {
  static const routeName = "/lesson";

  @override
  Widget build(BuildContext context) {
    final _lesson = ModalRoute.of(context)?.settings.arguments as Lesson;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _lesson.title,
        ),
      ),
      body: _lesson.filecards.length > 0
          ? GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (ctx, i) {
                final fileCard = _lesson.filecards[i];
                return FileCardPreviewCard(
                  key: ValueKey(fileCard.id),
                  fileCard: fileCard,
                );
              },
              itemCount: _lesson.filecards.length,
            )
          : Center(
              child: Text("No Filecards created yet."),
            ),
    );
  }
}
