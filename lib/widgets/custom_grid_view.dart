import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_trainer/utils/device_size.dart';
import 'package:vocab_trainer/widgets/responsive_container.dart';

class CustomGridView extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  const CustomGridView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  late double _width;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    double _containerWidth = min(DeviceSize.xxl, _width);

    return ResponsiveContainer(
      child: GridView.builder(
        key: widget.key,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (_containerWidth ~/ 190).toInt(),
        ),
        itemBuilder: widget.itemBuilder,
        itemCount: widget.itemCount,
      ),
    );
  }
}
