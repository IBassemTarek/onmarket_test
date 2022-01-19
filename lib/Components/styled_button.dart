import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onmarket_test/Components/styled_text.dart';

class StyledButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const StyledButton({
    this.onTaped,
    this.borderRadius = 20,
    this.title = '',
    this.height = 0.0,
    this.fontSize = 16,
    this.width = 0.0,
    this.color = Colors.black,
    this.textColor = Colors.black,
  });
  final void Function()? onTaped;
  final String title;
  final double borderRadius;
  final double height;
  final double fontSize;
  final double width;
  final Color color;

  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTaped,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        alignment: Alignment.center,
        height: height,
        width: width,
        child: StyledText(
          color: textColor,
          text: title,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
