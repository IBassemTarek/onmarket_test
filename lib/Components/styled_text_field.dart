import 'package:flutter/material.dart';
import './styled_text.dart';

class StyledTextField extends StatelessWidget {
  final String hintText;
  final String lableText;
  final Color color;
  final double fontSize;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  // ignore: use_key_in_widget_constructors
  const StyledTextField({
    this.color = Colors.black,
    this.fontSize = 16,
    this.hintText = '',
    this.lableText = '',
    required this.onSaved,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyledText(
          color: Colors.grey.shade900,
          fontSize: 14,
          text: lableText,
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
