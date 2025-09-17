import 'package:flutter/material.dart';

/// A simple, centered "Buy the Book" heading used below the promo section.
class BuyBookTitle extends StatelessWidget {
  const BuyBookTitle({
    super.key,
    this.text = 'Buy the Book',
    this.topPadding = 32.0,
    this.bottomPadding = 48.0,
    this.fontSize = 45.0,
    this.fontWeight = FontWeight.w600,
    this.color = const Color(0xFF2D2D2D),
    this.letterSpacing = 0.2,
  });

  final String text;
  final double topPadding;
  final double bottomPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            letterSpacing: letterSpacing,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}

/// Subtext shown under the BuyBookTitle with hover underline on the
/// "Order online" fragment only.
class BuyBookSubtext extends StatefulWidget {
  const BuyBookSubtext({
    super.key,
    this.topPadding = 4.0,
    this.bottomPadding = 48.0,
    this.color = const Color.fromARGB(255, 60, 59, 59),
    this.linkColor = const Color.fromARGB(255, 60, 59, 59),
    this.hoverLinkColor = const Color(0xFFF9742C),
    this.fontSize = 20.0,
    this.normalOpacity = 0.85,
    this.hoverOpacity = 1.0,
    this.hoverDuration = const Duration(milliseconds: 180),
  });

  final double topPadding;
  final double bottomPadding;
  final Color color;
  final Color linkColor;
  final Color hoverLinkColor;
  final double fontSize;
  final double normalOpacity;
  final double hoverOpacity;
  final Duration hoverDuration;

  @override
  State<BuyBookSubtext> createState() => _BuyBookSubtextState();
}

class _BuyBookSubtextState extends State<BuyBookSubtext> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding, bottom: widget.bottomPadding),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              ' ',
              style: TextStyle(fontSize: widget.fontSize),
            ),
            MouseRegion(
              onEnter: (_) => setState(() => _hovering = true),
              onExit: (_) => setState(() => _hovering = false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  duration: widget.hoverDuration,
                  opacity: _hovering ? widget.hoverOpacity : widget.normalOpacity,
                  child: AnimatedDefaultTextStyle(
                    duration: widget.hoverDuration,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: _hovering ? widget.hoverLinkColor : widget.linkColor,
                      decoration: _hovering ? TextDecoration.underline : TextDecoration.none,
                      decorationThickness: 1.5,
                    ),
                    child: const Text('Order online'),
                  ),
                ),
              ),
            ),
            Text(
              ' or purchase it from your local bookstore, or anywhere books are sold.',
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
