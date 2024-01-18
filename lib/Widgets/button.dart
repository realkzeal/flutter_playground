import 'package:flutter/material.dart';
import '../utils/theme.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonStyle? customButtonStyle;
final String text;
  final TextStyle? textStyle;
  const Button({super.key,
    this.onPressed,
    required this.text,
    this.customButtonStyle,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: customButtonStyle ?? buttonStyle,
      onPressed: onPressed,
      child: Text(text, style: textStyle ?? headline1Style,),)
    ;
  }
}
