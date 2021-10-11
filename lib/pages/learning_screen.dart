/// Full credits on the card flip animation go to https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:vocab_trainer/models/models.dart';
import 'package:vocab_trainer/widgets/widgets.dart';

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
    FileCard _currentCard() => _lesson.filecards[_currentPosition];
    double _successRate() => _correctCards.length / _lesson.filecards.length;

    final mediaQuery = MediaQuery.of(context);
    var _height = mediaQuery.size.height;

    // #region Card
    Widget __buildCard({
      required Key key,
      required String content,
      required String a11yLabel,
    }) =>
        Container(
          key: key,
          height: _height * 0.5,
          margin: EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).colorScheme.background,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Semantics(
                  label: a11yLabel,
                  child: Text(content),
                ),
              ),
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
            ? __buildCard(
                key: ValueKey(true),
                content: fileCard.question,
                a11yLabel: "Frage",
              )
            : __buildCard(
                key: ValueKey(false),
                content: fileCard.answer,
                a11yLabel: "Antwort",
              ),
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
      required String a11yLabel,
      required SemanticsSortKey sortKey,
    }) =>
        MergeSemantics(
          child: Semantics(
            sortKey: sortKey,
            button: true,
            enabled: true,
            label: a11yLabel,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(17.0),
                primary: color,
              ),
              onPressed: onTapHandler,
              child: Icon(icon),
            ),
          ),
        );

    Widget __buildFlipButton() => Container(
          key: ValueKey(true),
          child: __buildButton(
            onTapHandler: _flipCard,
            icon: Icons.sync,
            color: Theme.of(context).colorScheme.secondary,
            a11yLabel: "Karte drehen",
            sortKey: OrdinalSortKey(_showFrontSide ? 1 : 2),
          ),
        );

    Widget __buildWrongButton() => __buildButton(
          onTapHandler: _wrongHandler,
          icon: Icons.close,
          color: Theme.of(context).colorScheme.error,
          a11yLabel: "Falsch beantwortet",
          sortKey: OrdinalSortKey(1),
        );

    Widget __buildCorrectButton() => __buildButton(
          onTapHandler: _correctHandler,
          icon: Icons.check,
          color: Colors.greenAccent,
          a11yLabel: "Richtig beantwortet",
          sortKey: OrdinalSortKey(3),
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Semantics(
          sortKey: OrdinalSortKey(_showFrontSide ? 2 : 4),
          child: AppBar(
            title: Text(_lesson.title),
            leading: CustomBackButton(),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      body: Semantics(
        sortKey: OrdinalSortKey(0),
        child: ResponsiveContainer(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _showEndScreen
                ? LearningEndCard(
                    dataMap: {
                      "correct": _correctCards.length.toDouble(),
                      "wrong": _wrongCards.length.toDouble(),
                      "unanswered": (_lesson.filecards.length -
                              _correctCards.length -
                              _wrongCards.length)
                          .toDouble(),
                    },
                    endMessage: _endMessage(_successRate()),
                    summaryText:
                        "${_correctCards.length}/${_lesson.filecards.length} cards correct",
                    a11ySummary:
                        "${_correctCards.length} of ${_lesson.filecards.length} cards correct",
                  )
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
    );
  }
}
