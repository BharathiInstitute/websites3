import 'package:flutter/material.dart';
import '../widgets/hover_title.dart';
import 'sub_title.dart';
import 'heading_s.dart';

/// Composed overlay content for the hero section related to the
/// "My Morning Routine" experience. Centralizes all text overlays
/// so future additions live in one place.
class MorningHeroContent extends StatelessWidget {
  const MorningHeroContent({
    super.key,
    required this.title,
    this.subtitle,
    this.titleAlignment = Alignment.topRight,
    this.titlePadding = const EdgeInsets.only(top: 38.0, right: 1190.0),
    this.titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    this.subtitleLineHeight = 1.1,
    this.onNavTap,
    this.onMoreSelected,
  });

  final String title;
  final String? subtitle;
  final Alignment titleAlignment;
  final EdgeInsets titlePadding;
  final TextStyle titleStyle;
  final double subtitleLineHeight;
  // Handle top-right nav taps (Routines/Book/Stats/About). Provided by home.
  final ValueChanged<String>? onNavTap;
  // Handle selection from the More dropdown.
  final ValueChanged<String>? onMoreSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-right heading/menu items with fade hover effect
  HeadingS(onItemTap: onNavTap, onMoreSelected: onMoreSelected),
        // Title with fade-only hover (no slide, no color change, no letter-spacing change)
        HoverTitle(
          text: title,
          alignment: titleAlignment,
          padding: titlePadding,
          normalOpacity: 0.85,
          hoverOpacity: 1.0,
          hoverOffsetFractionY: 0.0,
          normalLetterSpacing: 0.0,
          hoverLetterSpacing: 0.0,
          normalColor: null,
          hoverColor: null,
          textStyle: titleStyle,
        ),
        if (subtitle != null)
          SubTitle(
            text: subtitle!,
            lineHeight: subtitleLineHeight,
          ),
      ],
    );
  }
}
