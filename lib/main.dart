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
  double right = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toLeft() {
    setState(() {
      left += 10;
    });
  }

  void _toRight() {
    setState(() {
      left -= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .8,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                AnimatedPositioned(
                  left: left,
                  right: right,
                  top: MediaQuery.of(context).size.height * .5 / 2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Container(
                          width: squareSize,
                          height: squareSize,
                          decoration: BoxDecoration(
                            color: Colors.red,
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
              onPressed: _toLeft,
              child: const Text("To the left"),
            ),
            ElevatedButton(
              onPressed: _toRight,
              child: const Text("To the right"),
            ),
            ElevatedButton(
              onPressed: _reset,
              child: const Text("reset"),
            )
          ],
        )
      ],
    );
  }

  void _reset() {
    setState(() {
      left = .0;
      right = .0;
    });
  }
}
