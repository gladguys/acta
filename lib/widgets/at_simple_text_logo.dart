import 'package:flutter/material.dart';

class ATSimpleTextLogo extends StatelessWidget {
  ATSimpleTextLogo({
    @required this.text,
    @required this.fontSize,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Italianno',
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.brown[800],
      ),
    );
  }
}
