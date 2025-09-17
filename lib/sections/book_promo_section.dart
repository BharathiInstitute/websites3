import 'package:flutter/material.dart';

/// A book promo section inspired by the reference screenshot.
/// - Light peach background with a slanted top edge
/// - Left: descriptive text + two CTA buttons
/// - Right: the book image (assets/2.png)
class BookPromoSection extends StatelessWidget {
  const BookPromoSection({
    super.key,
    this.backgroundColor = const Color(0xFFFFE8E0),
    this.primaryColor = const Color(0xFFF9742C),
    this.maxTextWidth = 720,
    this.bookImageWidth = 460,
    this.textRightShift = 0,
    this.textTopShift = 0,
    this.paragraphText =
        "Today’s most talented creatives and         businesspeople share their secrets to unlocking greater energy, focus, and       calm—starting first thing in the morning.",
    this.paragraphFontSizeWide = 44,
    this.paragraphFontSizeNarrow = 55,
    this.paragraphLineHeightWide = 1.4,
    this.paragraphLineHeightNarrow = 1.5,
    this.paragraphColor = const Color(0xFF2D2D2D),
    this.paragraphFontWeight = FontWeight.w500,
    this.paragraphOffsetX = 0,
    this.paragraphOffsetY = 0,
    this.ctaWidth = 200,
    this.ctaHeight = 56,
    this.ctaPaddingHWide = 28,
    this.ctaPaddingVWide = 16,
    this.ctaPaddingHNarrow = 24,
    this.ctaPaddingVNarrow = 14,
    this.bookImageOffsetX = 0,
    this.bookImageOffsetY = 0,
  });

  final Color backgroundColor;
  final Color primaryColor;
  final double maxTextWidth;
  final double bookImageWidth;
  final double textRightShift;
  final double textTopShift;
  final String paragraphText;
  final double paragraphFontSizeWide;
  final double paragraphFontSizeNarrow;
  final double paragraphLineHeightWide;
  final double paragraphLineHeightNarrow;
  final Color paragraphColor;
  final FontWeight paragraphFontWeight;
  final double paragraphOffsetX;
  final double paragraphOffsetY;
  final double ctaWidth;
  final double ctaHeight;
  final double ctaPaddingHWide;
  final double ctaPaddingVWide;
  final double ctaPaddingHNarrow;
  final double ctaPaddingVNarrow;
  final double bookImageOffsetX;
  final double bookImageOffsetY;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1000;
        final horizontal = isWide ? 100.0 : 24.0;
        final vertical = isWide ? 80.0 : 40.0;

        if (isWide) {
          // Desktop/tablet: Stack allows the book to overlap upward into the hero
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: ClipPath(
                  clipper: _SlantedTopClipper(),
                  child: Container(color: backgroundColor),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontal + textRightShift,
                        vertical + 24 + textTopShift,
                        horizontal / 2,
                        vertical,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: Offset(paragraphOffsetX, paragraphOffsetY),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: maxTextWidth),
                              child: Text(
                                paragraphText,
                                style: TextStyle(
                                  color: paragraphColor,
                                  fontSize: paragraphFontSizeWide,
                                  fontWeight: paragraphFontWeight,
                                  height: paragraphLineHeightWide,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Wrap(
                            spacing: 28,
                            runSpacing: 16,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(ctaWidth, ctaHeight),
                                  padding: EdgeInsets.symmetric(horizontal: ctaPaddingHWide, vertical: ctaPaddingVWide),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: const Text('Buy the Book'),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: primaryColor, width: 2),
                                  foregroundColor: primaryColor,
                                  minimumSize: Size(ctaWidth, ctaHeight),
                                  padding: EdgeInsets.symmetric(horizontal: ctaPaddingHWide, vertical: ctaPaddingVWide),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text('Peek Inside'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SizedBox(height: bookImageWidth * 0.4),
                  ),
                ],
              ),
              Positioned(
                top: vertical + bookImageOffsetY,
                right: horizontal - bookImageOffsetX,
                child: Image.asset(
                  'assets/2.png',
                  width: bookImageWidth,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        }

        // Narrow screens: simple stacked layout (no overlap into hero)
        return Stack(
          children: [
            Positioned.fill(
              child: ClipPath(
                clipper: _SlantedTopClipper(),
                child: Container(color: backgroundColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontal + textRightShift,
                vertical + 24 + textTopShift,
                horizontal,
                vertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: Offset(paragraphOffsetX, paragraphOffsetY),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxTextWidth),
                      child: Text(
                        paragraphText,
                        style: TextStyle(
                          color: paragraphColor,
                          fontSize: paragraphFontSizeNarrow,
                          fontWeight: paragraphFontWeight,
                          height: paragraphLineHeightNarrow,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: Size(ctaWidth, ctaHeight),
                          padding: EdgeInsets.symmetric(horizontal: ctaPaddingHNarrow, vertical: ctaPaddingVNarrow),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text('Buy the Book'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primaryColor, width: 2),
                          foregroundColor: primaryColor,
                          minimumSize: Size(ctaWidth, ctaHeight),
                          padding: EdgeInsets.symmetric(horizontal: ctaPaddingHNarrow, vertical: ctaPaddingVNarrow),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Peek Inside'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/2.png',
                      width: bookImageWidth * 0.9,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SlantedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Create a slight downward-left -> upward-right diagonal along the top.
    final path = Path();
    path.moveTo(0, size.height * 0.08);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

