import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_trainer/utils/device_size.dart';

class ResponsiveContainer extends StatefulWidget {
  final Widget child;
  const ResponsiveContainer({Key? key, required this.child}) : super(key: key);

  @override
  _ResponsiveContainerState createState() => _ResponsiveContainerState();
}

class _ResponsiveContainerState extends State<ResponsiveContainer> {
  late double _width;

  @override
  Widget build(BuildContext context) {
    var __mediaQuery = MediaQuery.of(context);
    _width = __mediaQuery.size.width -
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
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
