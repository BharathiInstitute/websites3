import 'package:flutter/material.dart';

class PeekInsideSection extends StatelessWidget {
  final double headingFontSize;
  final double bodyFontSize;
  final EdgeInsets padding;
  final Color textColor;
  final Color linkHoverColor;
  final Color linkBaseColor;

  const PeekInsideSection({
    super.key,
    this.headingFontSize = 72,
    this.bodyFontSize = 20,
    this.padding = const EdgeInsets.symmetric(vertical: 64),
    this.textColor = Colors.black87,
    this.linkHoverColor = const Color(0xFFFF7A00), // orange
    this.linkBaseColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Peek Inside',
            style: TextStyle(
              fontSize: headingFontSize,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final maxWidth = screenWidth < 600
                  ? 540.0
                  : (screenWidth < 1100 ? 820.0 : 920.0);
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _PeekInsideParagraph(
                    bodyFontSize: bodyFontSize,
                    textColor: textColor,
                    linkBaseColor: linkBaseColor,
                    linkHoverColor: linkHoverColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PeekInsideParagraph extends StatelessWidget {
  final double bodyFontSize;
  final Color textColor;
  final Color linkBaseColor;
  final Color linkHoverColor;

  const _PeekInsideParagraph({
    required this.bodyFontSize,
    required this.textColor,
    required this.linkBaseColor,
    required this.linkHoverColor,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(fontSize: bodyFontSize, color: textColor, height: 1.6);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'Read the book’s '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _HoverLink(
              text: 'introduction and the first routine',
              fontSize: bodyFontSize,
              baseColor: linkBaseColor,
              hoverColor: linkHoverColor,
              onTap: () {},
            ),
          ),
          const TextSpan(text: ' included in our '),
          TextSpan(
            text: 'Getting Up',
            style: baseStyle.copyWith(fontStyle: FontStyle.italic),
          ),
          const TextSpan(text: ' chapter right now. In addition, save or print out our '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _HoverLink(
              text: 'free morning routines worksheet',
              fontSize: bodyFontSize,
              baseColor: linkBaseColor,
              hoverColor: linkHoverColor,
              onTap: () {},
            ),
          ),
          const TextSpan(text: ' to help you hit the ground running.'),
        ],
      ),
    );
  }
}

class _HoverLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color baseColor;
  final Color hoverColor;
  final Duration duration = const Duration(milliseconds: 160);
  final VoidCallback? onTap;

  const _HoverLink({
    required this.text,
    required this.fontSize,
    required this.baseColor,
    required this.hoverColor,
    this.onTap,
  });

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final targetColor = _hovering ? widget.hoverColor : widget.baseColor;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(begin: targetColor, end: targetColor),
          duration: widget.duration,
          curve: Curves.easeInOut,
          builder: (context, color, _) {
            return Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: color,
                decoration: TextDecoration.underline,
                decorationColor: color,
                decorationThickness: 1.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
