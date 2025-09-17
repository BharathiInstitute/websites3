import 'package:flutter/material.dart';

/// A reusable hero section that displays an image full-width with an optional overlay.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    this.imagePath = 'assets/1.png',
    this.aspectRatio = 16 / 9,
    this.height,
    this.viewportFraction,
    this.showGradientOverlay = true,
    this.child,
    this.showOverlayImage = true,
    this.overlayImagePath = 'assets/20.png',
    this.overlayWidth,
    this.overlayHeight,
    this.overlayBorderRadius = 30,
    this.overlayTop = 16.0,
    this.overlayLeft = -200.0,
    this.overlayRight,
  });

  /// Asset image path
  final String imagePath;

  /// Aspect ratio for the hero area when [height] is not provided
  final double aspectRatio;

  /// Fixed height for the hero area. If provided, overrides [aspectRatio].
  final double? height;

  /// Fraction of the current screen height to use for this hero (0-1). Overrides [aspectRatio] when set.
  final double? viewportFraction;

  /// Whether to show a dark-to-transparent gradient overlay
  final bool showGradientOverlay;

  /// Optional content over the hero, e.g., title/button
  final Widget? child;

  /// Whether to show the small overlay image (e.g., 20.png) on top-left
  final bool showOverlayImage;

  /// Path to the overlay image
  final String overlayImagePath;

  /// Desired dimensions for the overlay image (optional)
  final double? overlayWidth;
  final double? overlayHeight;

  /// Border radius for the overlay image
  final double overlayBorderRadius;

  /// Positioning for the overlay image
  final double overlayTop;
  final double? overlayLeft;
  final double? overlayRight;

  @override
  Widget build(BuildContext context) {
    final content = Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        if (showGradientOverlay)
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0x99000000),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        if (showOverlayImage)
          Positioned(
            top: overlayTop,
            left: overlayLeft,
            right: overlayRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(overlayBorderRadius),
              child: Image.asset(
                overlayImagePath,
                width: overlayWidth,
                height: overlayHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (child != null) child!,
      ],
    );

    // If viewportFraction provided, compute height from screen height
    if (viewportFraction != null) {
      final screenHeight = MediaQuery.of(context).size.height;
      return SizedBox(
        height: screenHeight * viewportFraction!.clamp(0.0, 1.0),
        width: double.infinity,
        child: content,
      );
    }

    if (height != null) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: content,
      );
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: content,
    );
  }
}
