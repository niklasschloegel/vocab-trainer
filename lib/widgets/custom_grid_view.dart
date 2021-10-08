import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_trainer/utils/device_size.dart';
import 'package:vocab_trainer/widgets/responsive_container.dart';

class CustomGridView extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  const CustomGridView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _fontScale = _mediaQuery.textScaleFactor;
    var _width = _mediaQuery.size.width;
    var _containerWidth = min(DeviceSize.xxl, _width);
    var _gridCount =
        max(1, (_containerWidth ~/ (190 / (_fontScale / 1.7))).round());

    return ResponsiveContainer(
      child: GridView.builder(
        key: key,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _gridCount,
        ),
        itemBuilder: itemBuilder,
        itemCount: itemCount,
      ),
    );
  }
}
