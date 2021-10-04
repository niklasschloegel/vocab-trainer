import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/pages/pages.dart';

class FileCardPreviewCard extends StatelessWidget {
  final FileCard fileCard;
  const FileCardPreviewCard({
    Key? key,
    required this.fileCard,
  }) : super(key: key);

  void _navigateToFileCard(BuildContext context) =>
      Navigator.of(context).pushNamed(
        FileCardPreviewScreen.routeName,
        arguments: fileCard,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
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
              fileCard.question,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
