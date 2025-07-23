import 'package:flutter/material.dart';

class CustomLabelText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isUpperCase;
  final TextDecoration? decoration;

  const CustomLabelText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.maxLines,
    this.overflow,
    this.isUpperCase = false,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
        ),
      ),
    );
  }
}
