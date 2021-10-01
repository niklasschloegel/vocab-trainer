import 'package:flutter/material.dart';
import 'package:vocab_trainer/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      routes: {
        CategoriesOverviewScreen.routeName: (_) => CategoriesOverviewScreen(),
        CategoryScreen.routeName: (_) => CategoryScreen(),
        FileCardPreviewScreen.routeName: (_) => FileCardPreviewScreen(),
        LearningScreen.routeName: (_) => LearningScreen(),
        LessonScreen.routeName: (_) => LessonScreen(),
      },
    );
  }
}
