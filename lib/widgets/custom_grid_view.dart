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
    var _width = _mediaQuery.size.width;
    double _containerWidth = min(DeviceSize.xxl, _width);

    return ResponsiveContainer(
      child: GridView.builder(
        key: key,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (_containerWidth ~/ 190).toInt(),
        ),
        itemBuilder: itemBuilder,
        itemCount: itemCount,
      ),
    );
  }
}
