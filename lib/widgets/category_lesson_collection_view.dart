import 'package:flutter/material.dart';

import 'custom_grid_view.dart';
import 'menu_card.dart';
import 'menu_item.dart';

class CategoryLessonCollectionView extends StatelessWidget {
  final List<MenuItem> menuItems;
  const CategoryLessonCollectionView({Key? key, required this.menuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGridView(
      itemBuilder: (ctx, index) {
        final menuItem = menuItems[index];
        return MenuCard(
          key: ValueKey(menuItem.id),
          title: menuItem.title,
          description: menuItem.description,
          navigate: menuItem.navigate,
        );
      },
      itemCount: menuItems.length,
    );
  }
}
