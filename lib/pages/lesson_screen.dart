import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/pages/pages.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

class LessonScreen extends StatelessWidget {
  static const routeName = "/lesson";

  @override
  Widget build(BuildContext context) {
    final _lesson = ModalRoute.of(context)?.settings.arguments as Lesson;
    return Scaffold(
      appBar: AppBar(
        title: Text(_lesson.title),
        leading: CustomBackButton(),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      floatingActionButton: _lesson.filecards.length > 0
          ? Semantics(
              sortKey: OrdinalSortKey(0),
              child: Semantics(
                label: "Lernen starten",
                button: true,
                enabled: true,
                child: ExcludeSemantics(
                  child: FloatingActionButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      LearningScreen.routeName,
                      arguments: _lesson,
                    ),
                    child: Icon(Icons.play_arrow),
                  ),
                ),
              ),
            )
          : null,
      body: Semantics(
        sortKey: OrdinalSortKey(1),
        child: _lesson.filecards.length > 0
            ? CustomGridView(
                itemBuilder: (ctx, i) {
                  final fileCard = _lesson.filecards[i];
                  return FileCardPreviewCard(
                    key: ValueKey(fileCard.id),
                    question: fileCard.question,
                    answer: fileCard.answer,
                  );
                },
                itemCount: _lesson.filecards.length,
              )
            : Center(
                child: Text(
                  "No Filecards created yet.",
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
