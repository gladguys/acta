import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ATSimpleTextLogo extends StatelessWidget {
  ATSimpleTextLogo({
    @required this.text,
    @required this.fontSize,
    this.duration,
    this.isRepeatingAnimation,
  });

  final String text;
  final double fontSize;
  final Duration duration;
  final bool isRepeatingAnimation;

  @override
  Widget build(BuildContext context) {
    return TyperAnimatedTextKit(
      text: [text],
      isRepeatingAnimation: isRepeatingAnimation,
      duration: duration,
      textStyle: TextStyle(
        fontFamily: 'Italianno',
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.brown[800],
      ),
      textAlign: TextAlign.center,
    );
  }
}
