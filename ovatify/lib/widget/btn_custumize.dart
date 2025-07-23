import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final double width;
  final double? fontsize;
  final double? borderwidth;

  CustomButton({
    required this.title,
    required this.onPressed,
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderRadius = 12.0,
    this.height = 55.0,
    this.borderwidth,
    this.fontsize,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderwidth ?? 2),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child:Text(
          title,
          style: textTheme.bodyLarge?.copyWith(fontSize: fontsize ?? 18, color: textColor, fontWeight: FontWeight.w300),
        ),
      ),

    );
  }
}