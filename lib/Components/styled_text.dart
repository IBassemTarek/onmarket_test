import 'package:flutter/material.dart';
import 'package:onmarket_test/Utils/constants.dart';

class StyledText extends StatelessWidget {
  final String text;
  final Color color;
  final bool lineThrough;
  final double fontSize;
  // ignore: use_key_in_widget_constructors
  const StyledText({
    this.lineThrough = false,
    this.color = kMainTextColor,
    this.fontSize = 16,
    this.text = '',
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: color,
        decorationThickness: 2.85,
        decoration: lineThrough ? TextDecoration.lineThrough : null,
        fontSize: fontSize,
      ),
    );
  }
}
