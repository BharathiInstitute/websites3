import 'package:flutter/material.dart';

/// A configurable title widget for "About the Book" with position and font size controls.
class AboutTheBookTitle extends StatelessWidget {
  final double fontSize;
  final double offsetY;
  final double offsetX;
  final FontWeight fontWeight;
  final Color color;
  final EdgeInsets padding;

  const AboutTheBookTitle({
    super.key,
    this.fontSize =65,
    this.offsetY = 0,
    this.offsetX = 0,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Transform.translate(
        offset: Offset(offsetX, offsetY),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About the Book',
              style: TextStyle(
                fontSize: fontSize + 20, // Increase font size by 16
                fontWeight: fontWeight,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
