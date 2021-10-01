import 'package:uuid/uuid.dart';

class FileCard {
  final id = Uuid().v1();
  String question;
  String answer;

  FileCard(this.question, this.answer);
}
