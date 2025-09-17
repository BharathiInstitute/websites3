import 'package:flutter/material.dart';

/// A centered title with a simple hover effect (opacity + slight slide and color change).
class HoverTitle extends StatefulWidget {
  const HoverTitle({
    super.key,
    required this.text,
    this.textStyle,
    this.hoverScale = 1.05,
    this.hoverOpacity = 1.0,
    this.normalOpacity = 0.9,
    this.hoverDuration = const Duration(milliseconds: 150),
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
    this.normalLetterSpacing = 0.0,
    this.hoverLetterSpacing = 0.5,
    this.hoverOffsetFractionY = -0.02,
    this.normalColor,
    this.hoverColor = const Color.fromARGB(255, 157, 157, 155),
  });

  final String text;
  final TextStyle? textStyle;
  final double hoverScale;
  final double hoverOpacity;
  final double normalOpacity;
  final Duration hoverDuration;
  final Alignment alignment;
  final EdgeInsets padding;
  final double normalLetterSpacing;
  final double hoverLetterSpacing;
  // Vertical slide on hover (fraction of height). Negative moves up.
  final double hoverOffsetFractionY;
  // Text color when not hovered; if null, uses style.color
  final Color? normalColor;
  // Text color when hovered; defaults to an accent
  final Color? hoverColor;

  @override
  State<HoverTitle> createState() => _HoverTitleState();
}

class _HoverTitleState extends State<HoverTitle> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle ?? Theme.of(context).textTheme.displaySmall?.copyWith(
              color: const Color.fromRGBO(230, 227, 227, 1),
              fontWeight: FontWeight.bold,
            ) ??
        const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(71, 70, 70, 1),
        );

    final effectiveStyle = style.copyWith(
      letterSpacing: _hovering ? widget.hoverLetterSpacing : widget.normalLetterSpacing,
      color: _hovering
          ? (widget.hoverColor ?? style.color)
          : (widget.normalColor ?? style.color),
    );

    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.padding,
        child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedOpacity(
          duration: widget.hoverDuration,
          opacity: _hovering ? widget.hoverOpacity : widget.normalOpacity,
          child: AnimatedSlide(
            duration: widget.hoverDuration,
            offset: _hovering ? Offset(0, widget.hoverOffsetFractionY) : Offset.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: widget.hoverDuration,
                  style: effectiveStyle,
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
