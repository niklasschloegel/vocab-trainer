import 'package:flutter/material.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

class FileCardPreviewScreen extends StatelessWidget {
  static const routeName = "/filecard-preview";

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)?.settings.arguments as List<String>;
    final _question = _args[0];
    final _answer = _args[1];

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
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Filecard Preview"),
        leading: CustomBackButton(),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ResponsiveContainer(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPreviewCard("Question", _question),
                SizedBox(
                  height: 20,
                ),
                _buildPreviewCard("Answer", _answer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
