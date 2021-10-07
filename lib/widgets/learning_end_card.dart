import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vocab_trainer/utils/device_size.dart';

class LearningEndCard extends StatefulWidget {
  final Map<String, double> dataMap;
  final String endMessage;
  final String summaryText;
  const LearningEndCard({
    Key? key,
    required this.dataMap,
    required this.endMessage,
    required this.summaryText,
  }) : super(key: key);

  @override
  _LearningEndCardState createState() => _LearningEndCardState();
}

class _LearningEndCardState extends State<LearningEndCard> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var _width = mediaQuery.size.width;
    var _height = mediaQuery.size.height;
    var _isPortrait = mediaQuery.orientation == Orientation.portrait;
    double _pieChartRadius = min(_height, min(DeviceSize.xxl, _width)) / 2.5;

    Widget __buildPieChart() => PieChart(
          dataMap: widget.dataMap,
          animationDuration: Duration(milliseconds: 500),
          chartRadius: _pieChartRadius,
          colorList: [
            Colors.greenAccent,
            Colors.redAccent,
            Colors.grey,
          ],
          chartType: ChartType.ring,
          ringStrokeWidth: 40,
          legendOptions: LegendOptions(
            legendPosition:
                !_isPortrait ? LegendPosition.right : LegendPosition.bottom,
            showLegendsInRow: _isPortrait,
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
          ),
        );

    Widget __buildEndMessage() => Text(
          widget.endMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        );

    Widget __buildSummaryText() =>
        Text(widget.summaryText, style: Theme.of(context).textTheme.subtitle1);

    Widget __buildChartCard() => Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(25.0),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  __buildPieChart(),
                  _isPortrait ? __buildSummaryText() : Container(),
                ],
              ),
            ),
          ),
        );

    Widget __buildBackButton() => ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
          ),
          onPressed: Navigator.of(context).pop,
          child: Text("Back"),
        );

    Widget __endScreenPortrait() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            __buildEndMessage(),
            __buildChartCard(),
            __buildBackButton(),
          ],
        );

    Widget __endScreenLandscape() => Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  __buildEndMessage(),
                  SizedBox(height: 8),
                  __buildSummaryText(),
                  SizedBox(height: 12),
                  __buildBackButton(),
                ],
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  __buildChartCard(),
                ],
              ),
              flex: 3,
            ),
          ],
        );

    return _isPortrait ? __endScreenPortrait() : __endScreenLandscape();
  }
}