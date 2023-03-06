import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SquareAnimation(),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation>
    with TickerProviderStateMixin {
  static const squareSize = 50.0;
  double _left = 0.0;
  double _top = 0.0;
  final List<Color> _colors = [Colors.red, Colors.green, Colors.blue];

  late dynamic onLeft;
  late dynamic onRight;
  late double _width;
  late Color _currentColor;

  void setupButtons() {
    onLeft = () {
      toggle(_width);
    };
    onRight = () {
      toggle(_width);
    };
  }

  @override
  void initState() {
    _currentColor = _colors[Random().nextInt(_colors.length)];
    setupButtons();
    _width = 0.0;

    super.initState();
  }

  void toggle(double value) {
    setState(() {
      _currentColor = _colors[Random().nextInt(_colors.length)];
      onLeft = null;
      onRight = null;
      if (_left == 0) {
        _left = value - squareSize;
      } else {
        _left = 0;
      }
    });
  }

  final _defaultDuration = const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    double boxHeight = MediaQuery.of(context).size.height * .5;
    double boxWidth = MediaQuery.of(context).size.width;
    _width = boxWidth;
    _top = MediaQuery.of(context).size.height * .5 / 2;
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: boxHeight,
            width: boxWidth,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    left: _left,
                    top: _top,
                    duration: _defaultDuration,
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: squareSize,
                      height: squareSize,
                      decoration: BoxDecoration(
                        color: _currentColor,
                        border: Border.all(),
                      ),
                    ),
                    onEnd: () {
                      setState(() {
                        setupButtons();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onRight,
                  child: const Text("To the right"),
                ),
                ElevatedButton(
                  onPressed: onLeft,
                  child: const Text("To the left"),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
