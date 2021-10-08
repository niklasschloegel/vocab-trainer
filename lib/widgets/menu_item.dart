import 'package:flutter/material.dart';

class MenuItem {
  final String id;
  final String title;
  final String description;
  final Function(BuildContext) navigate;

  MenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.navigate,
  });
}
