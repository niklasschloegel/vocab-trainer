/// Full credits on the rotation animation go to https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_trainer/models/models.dart';

class LearningScreen extends StatefulWidget {
  static const routeName = "/learning";

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  bool _showFrontSide = true;

  void _switchCard() => setState(() => _showFrontSide = !_showFrontSide);

  @override
  Widget build(BuildContext context) {
    final _lesson = ModalRoute.of(context)?.settings.arguments as Lesson;
    final mediaQuery = MediaQuery.of(context);

    Widget __buildLayout({
      required Key key,
      required String faceName,
    }) {
      return Container(
        key: key,
        height: mediaQuery.size.height * 0.5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Center(
          child: Text(faceName),
        ),
      );
    }

    Widget _buildFront() =>
        __buildLayout(key: ValueKey(true), faceName: "Front");

    Widget _buildRear() =>
        __buildLayout(key: ValueKey(false), faceName: "Rear");

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

    Widget _buildFlipAnimation() {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
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
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      );
    }

    Widget __buildButton({
      required VoidCallback onTapHandler,
      required IconData icon,
      required Color color,
    }) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(17.0),
          primary: color,
        ),
        onPressed: onTapHandler,
        child: Icon(icon),
      );
    }

    Widget __buildFlipButton() => __buildButton(
          onTapHandler: _switchCard,
          icon: Icons.sync,
          color: Theme.of(context).colorScheme.secondary,
        );

    Widget __buildWrongButton() => __buildButton(
          onTapHandler: () {},
          icon: Icons.close,
          color: Theme.of(context).colorScheme.error,
        );

    Widget __buildCorrectButton() => __buildButton(
          onTapHandler: () {},
          icon: Icons.check,
          color: Colors.greenAccent,
        );

    Widget _buildIconRow() {
      return _showFrontSide
          ? __buildFlipButton()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                __buildWrongButton(),
                SizedBox(width: 30),
                __buildFlipButton(),
                SizedBox(width: 30),
                __buildCorrectButton()
              ],
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_lesson.title),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFlipAnimation(),
                _buildIconRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
