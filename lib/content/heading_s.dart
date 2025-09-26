import 'package:flutter/material.dart';
import '../widgets/drop_down.dart';

/// A simple top-right heading/menu with fade hover effect per item.
class HeadingS extends StatelessWidget {
  const HeadingS({
    super.key,
    this.items = const ['Routines', 'Book', 'Stats', 'About', 'More'],
    this.alignment = Alignment.topRight,
    this.padding = const EdgeInsets.only(top: 38.0, right: 350.0),
    this.spacing = 40.0,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    this.onItemTap,
    this.moreOptions = const <String>[
      'Q&A',
      'Quotes',
      'Deals',
      'Products',
      'Library',
      'Articles',
      'Press',
    ],
    this.onMoreSelected,
  });

  final List<String> items;
  final Alignment alignment;
  final EdgeInsets padding;
  final double spacing;
  final TextStyle textStyle;
  // Called when a non-"More" nav item is tapped. Receives the label.
  final ValueChanged<String>? onItemTap;
  final List<String> moreOptions;
  final ValueChanged<String>? onMoreSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: Wrap(
          spacing: spacing,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: items.map((label) {
            if (label.toLowerCase() == 'more') {
              return MoreDropdown(
                label: label,
                textStyle: textStyle,
                iconColor: textStyle.color,
                options: moreOptions,
                highlightLabel: 'Deals',
                onSelected: onMoreSelected,
              );
            }
            return _HoverFadeText(
              label: label,
              style: textStyle,
              onTap: onItemTap != null ? () => onItemTap!(label) : null,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _HoverFadeText extends StatefulWidget {
  const _HoverFadeText({
    required this.label,
    required this.style,
    this.onTap,
  });

  final String label;
  final TextStyle style;
  final VoidCallback? onTap;

  @override
  State<_HoverFadeText> createState() => _HoverFadeTextState();
}

class _HoverFadeTextState extends State<_HoverFadeText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final child = AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: _hovering ? 1.0 : 0.8,
      child: Text(widget.label, style: widget.style),
    );

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: widget.onTap != null
          ? GestureDetector(behavior: HitTestBehavior.opaque, onTap: widget.onTap, child: child)
          : child,
    );
  }
}
