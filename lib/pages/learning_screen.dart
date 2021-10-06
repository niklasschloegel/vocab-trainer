/// Full credits on the card flip animation go to https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vocab_trainer/models/models.dart';

class LearningScreen extends StatefulWidget {
  static const routeName = "/learning";

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final _carouselController = CarouselController();
  final _animationDuration = Duration(milliseconds: 800);
  var _showEndScreen = false;
  var _showFrontSide = true;
  var _currentPosition = 0;
  var _correctCards = [];
  var _wrongCards = [];

  void _flipCard() => setState(() => _showFrontSide = !_showFrontSide);
  String _endMessage(double percentage) {
    if (percentage <= 0.3) {
      return "You can do better!";
    } else if (percentage <= 0.6) {
      return "Keep up, you are close to your goal!";
    } else {
      return "Well done!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final _lesson = ModalRoute.of(context)?.settings.arguments as Lesson;
    final mediaQuery = MediaQuery.of(context);
    FileCard _currentCard() => _lesson.filecards[_currentPosition];
    double _successRate() => _correctCards.length / _lesson.filecards.length;

    // #region Card
    Widget __buildCard({
      required Key key,
      required String content,
    }) =>
        Container(
          key: key,
          height: mediaQuery.size.height * 0.5,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(content),
            ),
          ),
        );

    Widget __transitionBuilder(Widget widget, Animation<double> animation) {
      final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
      return AnimatedBuilder(
        animation: rotateAnim,
        child: widget,
        builder: (context, widget) {
          final isUnder = (ValueKey(_showFrontSide) != widget?.key);
          var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
          tilt *= isUnder ? -1.0 : 1.0;
          final value =
              isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
          return Transform(
            transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
            child: widget,
            alignment: Alignment.center,
          );
        },
      );
    }

    Widget __buildFlipAnimation(FileCard fileCard) {
      return AnimatedSwitcher(
        duration: _animationDuration,
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) {
          final _widget = widget;
          if (_widget != null) {
            return Stack(children: [_widget, ...list]);
          }
          return Stack(
            children: [...list],
          );
        },
        child: _showFrontSide
            ? __buildCard(key: ValueKey(true), content: fileCard.question)
            : __buildCard(key: ValueKey(false), content: fileCard.answer),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      );
    }

    Widget _buildCardCarousel() => CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            initialPage: 0,
            height: mediaQuery.size.height * 0.5,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            onScrolled: (d) => setState(
              () {
                if (d != null) _currentPosition = d.toInt();
                if (!_showFrontSide) _flipCard();
              },
            ),
          ),
          carouselController: _carouselController,
          items: _lesson.filecards.map((card) {
            return __buildFlipAnimation(card);
          }).toList(),
        );

    // #endregion

    // #region Switch Cards

    void __nextCard() {
      _flipCard();
      _carouselController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        if ((_currentPosition + 1) < _lesson.filecards.length) {
          _currentPosition++;
        } else {
          _showEndScreen = true;
        }
      });
    }

    void _correctHandler() {
      _correctCards.add(_currentCard());
      __nextCard();
    }

    void _wrongHandler() {
      _wrongCards.add(_currentCard());
      __nextCard();
    }

    // #endregion

    // #region Buttons
    Widget __buildButton({
      required VoidCallback onTapHandler,
      required IconData icon,
      required Color color,
    }) =>
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(17.0),
            primary: color,
          ),
          onPressed: onTapHandler,
          child: Icon(icon),
        );

    Widget __buildFlipButton() => Container(
          key: ValueKey(true),
          child: __buildButton(
            onTapHandler: _flipCard,
            icon: Icons.sync,
            color: Theme.of(context).colorScheme.secondary,
          ),
        );

    Widget __buildWrongButton() => __buildButton(
          onTapHandler: _wrongHandler,
          icon: Icons.close,
          color: Theme.of(context).colorScheme.error,
        );

    Widget __buildCorrectButton() => __buildButton(
          onTapHandler: _correctHandler,
          icon: Icons.check,
          color: Colors.greenAccent,
        );

    Widget __buildIconRow() => Row(
          key: ValueKey(false),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            __buildWrongButton(),
            SizedBox(width: 30),
            __buildFlipButton(),
            SizedBox(width: 30),
            __buildCorrectButton()
          ],
        );

    Widget _buildButtons() => AnimatedSwitcher(
          duration: _animationDuration,
          child: _showFrontSide ? __buildFlipButton() : __buildIconRow(),
          transitionBuilder: (child, animation) =>
              ScaleTransition(child: child, scale: animation),
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
        );

    // #endregion

    // #region Endscreen
    Widget __buildPieChart() => PieChart(
          dataMap: {
            "correct": _correctCards.length.toDouble(),
            "wrong": _wrongCards.length.toDouble(),
            "unanswered": (_lesson.filecards.length -
                    _correctCards.length -
                    _wrongCards.length)
                .toDouble(),
          },
          animationDuration: Duration(milliseconds: 500),
          chartRadius: mediaQuery.size.width / 2.5,
          colorList: [
            Colors.greenAccent,
            Colors.redAccent,
            Colors.grey,
          ],
          chartType: ChartType.ring,
          ringStrokeWidth: 40,
          legendOptions: LegendOptions(
            legendPosition: LegendPosition.bottom,
            showLegendsInRow: true,
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
          ),
        );

    Widget _buildEndScreen() => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _endMessage(_successRate()),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 30),
              Container(
                width: mediaQuery.size.width * 0.92,
                height: mediaQuery.size.height * 0.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        __buildPieChart(),
                        SizedBox(height: 30),
                        Text(
                            "${_correctCards.length}/${_lesson.filecards.length} cards correct",
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: Navigator.of(context).pop,
                child: Text("Back"),
              ),
            ],
          ),
        );
    // #endregion

    return Scaffold(
      appBar: AppBar(
        title: Text(_lesson.title),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _showEndScreen
                  ? _buildEndScreen()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCardCarousel(),
                        _buildButtons(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
