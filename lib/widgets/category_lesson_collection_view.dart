import 'package:flutter/material.dart';
import 'package:vocab_trainer/utils/device_size.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

import 'custom_grid_view.dart';
import 'menu_card.dart';
import 'menu_item.dart';

class CategoryLessonCollectionView extends StatelessWidget {
  final List<MenuItem> menuItems;
  const CategoryLessonCollectionView({Key? key, required this.menuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _shortestSide = _mediaQuery.size.shortestSide;
    var _fontScale = _mediaQuery.textScaleFactor;
    bool _showGrid() {
      if (_shortestSide < DeviceSize.m) return false;
      if (_shortestSide < DeviceSize.xl && _fontScale > 1.5) return false;
      return true;
    }

    print("shortestSide: $_shortestSide fontScale: $_fontScale");

    return _showGrid()
        ? CustomGridView(
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
          )
        : ResponsiveContainer(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final menuItem = menuItems[index];
                return Card(
                  child: ListTile(
                    key: ValueKey(menuItem.id),
                    title: Text(
                      menuItem.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(menuItem.description),
                    onTap: () => menuItem.navigate(ctx),
                  ),
                );
              },
              itemCount: menuItems.length,
            ),
          );
  }
}
