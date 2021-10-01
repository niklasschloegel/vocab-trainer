import 'package:uuid/uuid.dart';
import 'package:vocab_trainer/models/lesson.dart';

class Category {
  final id = Uuid().v1();
  String title;
  List<Lesson> lessons;

  Category(this.title, this.lessons);
}
