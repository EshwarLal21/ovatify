
import 'package:flutter/material.dart';

enum IconPosition { left, right }

class CustomIconButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  final String? assetPath;
  final IconData? iconData;

  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final double width;
  final double iconSize;
  final double spacing;
  final IconPosition iconPosition;

  const CustomIconButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.assetPath,
    this.iconData,
    this.iconPosition = IconPosition.left,
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderRadius = 12.0,
    this.height = 55.0,
    this.width = double.infinity,
    this.iconSize = 24.0,
    this.spacing = 8.0,
  }) : assert(
  assetPath != null || iconData != null,
  'Either assetPath or iconData must be provided',
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 2),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPosition == IconPosition.left) ...[
              _buildIcon(),
              SizedBox(width: spacing),
            ],
            Text(
              title,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (iconPosition == IconPosition.right) ...[
              SizedBox(width: spacing),
              _buildIcon(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        height: iconSize,
        width: iconSize,
      );
    } else if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize,
        color: textColor,
      );
    } else {
      return const SizedBox();
    }
  }
}
