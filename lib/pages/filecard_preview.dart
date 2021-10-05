import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';

class FileCardPreviewScreen extends StatelessWidget {
  static const routeName = "/filecard-preview";

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    Widget _buildPreviewCard(String title, String content) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.subtitle1),
            Center(
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: Container(
                  height: _mediaQuery.size.height * 0.34,
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(content),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final _fileCard = ModalRoute.of(context)?.settings.arguments as FileCard;
    return Scaffold(
      appBar: AppBar(
        title: Text("Filecard Preview"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPreviewCard("Question", _fileCard.question),
              _buildPreviewCard("Answer", _fileCard.answer),
            ],
          ),
        ),
      ),
    );
  }
}
