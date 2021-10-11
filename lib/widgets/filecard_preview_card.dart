import 'package:flutter/material.dart';
import 'package:vocab_trainer/pages/pages.dart';

class FileCardPreviewCard extends StatelessWidget {
  final String question;
  final String answer;
  const FileCardPreviewCard({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  void _navigateToFileCard(BuildContext context) =>
      Navigator.of(context).pushNamed(
        FileCardPreviewScreen.routeName,
        arguments: [question, answer],
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => _navigateToFileCard(context),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Text(
              question,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
