import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  final EdgeInsets padding;
  final double linkFontSize;
  final double legalFontSize;
  final Color baseColor;
  final Color hoverColor;
  final Color backgroundColor;
  final int? endYear; // allow fixing end year instead of always using current

  const FooterSection({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 40),
    this.linkFontSize = 18,
    this.legalFontSize = 16,
    this.baseColor = const Color(0xFF8A8A8A), // grey
    this.hoverColor = const Color(0xFF5C5C5C), // darker grey on hover
    this.backgroundColor = const Color(0xFFF7F7F7),
    this.endYear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Prices update line (added above social links as requested)
            const Text(
              'Prices updated on Aug 17, 2024',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8A8A8A),
                letterSpacing: .25,
              ),
            ),
            const SizedBox(height: 28),
            _CenteredLinksRow(
              items: const ['Twitter', 'Facebook', 'Instagram', 'Mastodon'],
              fontSize: linkFontSize,
              baseColor: baseColor,
              hoverColor: Colors.black, // fade to black on hover
            ),
            const SizedBox(height: 16),
            _LegalRow(
              fontSize: legalFontSize,
              baseColor: baseColor,
              hoverColor: hoverColor,
              endYear: endYear,
            ),
          ],
        ),
      ),
    );
  }
}

class _CenteredLinksRow extends StatelessWidget {
  final List<String> items;
  final double fontSize;
  final Color baseColor;
  final Color hoverColor;

  const _CenteredLinksRow({
    required this.items,
    required this.fontSize,
    required this.baseColor,
    required this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 28,
      alignment: WrapAlignment.center,
      children: [
        for (final item in items)
          _FadeLink(
            text: item,
            fontSize: fontSize,
            baseColor: baseColor,
            hoverColor: hoverColor,
          ),
      ],
    );
  }
}

class _LegalRow extends StatelessWidget {
  final double fontSize;
  final Color baseColor;
  final Color hoverColor;
  final int? endYear;

  const _LegalRow({
    required this.fontSize,
    required this.baseColor,
    required this.hoverColor,
    this.endYear,
  });

  @override
  Widget build(BuildContext context) {
  final year = endYear ?? DateTime.now().year;
    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('© 2012-$year', style: TextStyle(color: baseColor, fontSize: fontSize)),
        const Text(' '),
        _FadeLink(text: 'Michael Xander', fontSize: fontSize, baseColor: baseColor, hoverColor: hoverColor),
        const Text(' and '),
        _FadeLink(text: 'Benjamin Spall', fontSize: fontSize, baseColor: baseColor, hoverColor: hoverColor),
        const Text(' · '),
        _FadeLink(text: 'Legal', fontSize: fontSize, baseColor: baseColor, hoverColor: hoverColor),
        const Text(' · '),
        _FadeLink(text: 'Privacy', fontSize: fontSize, baseColor: baseColor, hoverColor: hoverColor),
      ].map((w) {
        if (w is Text) {
          return Text(w.data!, style: TextStyle(color: baseColor, fontSize: fontSize));
        }
        return w;
      }).toList(),
    );
  }
}

class _FadeLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color baseColor;
  final Color hoverColor;

  const _FadeLink({
    required this.text,
    required this.fontSize,
    required this.baseColor,
    required this.hoverColor,
  });

  @override
  State<_FadeLink> createState() => _FadeLinkState();
}

class _FadeLinkState extends State<_FadeLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = _hover ? widget.hoverColor : widget.baseColor;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        style: TextStyle(
          color: color,
          fontSize: widget.fontSize,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
