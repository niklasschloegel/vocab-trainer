import 'package:uuid/uuid.dart';
import 'package:vocab_trainer/models/filecard.dart';

class Lesson {
  final id = Uuid().v1();
  String title;
  List<FileCard> filecards;

  Lesson(this.title, this.filecards);
}
