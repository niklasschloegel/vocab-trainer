import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_trainer/utils/device_size.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  const ResponsiveContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var __mediaQuery = MediaQuery.of(context);
    var _width = __mediaQuery.size.width -
        __mediaQuery.padding.left -
        __mediaQuery.padding.right;

    double _containerWidth = min(DeviceSize.xxl, _width);

    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _containerWidth - 8,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
