import 'package:flutter/material.dart';

class AnimatedValueWidget extends StatelessWidget {
  final double targetValue;
  final TextStyle textStyle;
  // final String text;
  const AnimatedValueWidget({
    super.key,
    required this.targetValue,
    required this.textStyle,
    // required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Text(targetValue.toStringAsFixed(2), style: textStyle);
      },
    );
  }
}
