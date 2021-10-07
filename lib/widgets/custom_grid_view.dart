import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_trainer/utils/device_size.dart';

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
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    double containerWidth = min(DeviceSize.xxl, width);
    print("build called, width=$width, containerWidth=$containerWidth");

    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: containerWidth,
              child: Center(
                child: GridView.builder(
                  key: widget.key,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (containerWidth ~/ 190).toInt(),
                  ),
                  itemBuilder: widget.itemBuilder,
                  itemCount: widget.itemCount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
