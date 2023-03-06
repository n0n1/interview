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
  double left = 0.0;

  @override
  void initState() {
    super.initState();
  }

  void toggle(double value) {
    setState(() {
      if (left == 0) {
        left = value - squareSize;
      } else {
        left = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double boxHeight = MediaQuery.of(context).size.height * .5;
    double boxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: boxHeight,
          width: boxWidth,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                AnimatedPositioned(
                  left: left,
                  top: MediaQuery.of(context).size.height * .5 / 2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Container(
                          width: squareSize,
                          height: squareSize,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            border: Border.all(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: left == 0
                  ? () {
                      toggle(boxWidth);
                    }
                  : null,
              child: const Text("To the right"),
            ),
            ElevatedButton(
              onPressed: left > 0
                  ? () {
                      toggle(boxWidth);
                    }
                  : null,
              child: const Text("To the left"),
            ),
          ],
        )
      ],
    );
  }
}
