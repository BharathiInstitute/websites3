import 'package:flutter/material.dart';

class OnlineArchiveSection extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Color color;

  const OnlineArchiveSection({
    super.key,
    this.title = 'Online Archive',
    this.fontSize = 72,
    this.fontWeight = FontWeight.w700,
    this.padding = const EdgeInsets.symmetric(vertical: 64),
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class OnlineArchiveIntro extends StatelessWidget {
  final EdgeInsets padding;
  final double fontSize;
  final Color textColor;

  const OnlineArchiveIntro({
    super.key,
    this.padding = const EdgeInsets.only(top: 8, bottom: 32),
    this.fontSize = 20,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final maxWidth = screenWidth < 600
              ? 560.0
              : (screenWidth < 1100 ? 860.0 : 980.0);
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'The vast majority of the morning routines included in our book are exclusive to it. However, between December 2012 and July 2019, My Morning Routine also published a brand new, inspiring morning routine every week—341 in total—on this website. Here are some of our favorites:',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ArchiveFooterBlock extends StatelessWidget {
  final EdgeInsets padding;
  const ArchiveFooterBlock({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 40, 16, 60),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _ArchiveSocialIconsRow(),
          SizedBox(height: 42),
          _ArchiveFooterLinks(),
          SizedBox(height: 10),
          _ArchiveLegalLine(),
        ],
      ),
    );
  }
}

// --- Social Icons Row (twitter bird placeholder, facebook square, more) ---
class _ArchiveSocialIconsRow extends StatelessWidget {
  const _ArchiveSocialIconsRow();

  @override
  Widget build(BuildContext context) {
    const spacing = 56.0;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _CircleOutlineIcon(icon: Icons.alternate_email), // replace with bird asset if you have one
          SizedBox(width: spacing),
          _CircleOutlineIcon(icon: Icons.facebook),
          SizedBox(width: spacing),
          _CircleOutlineEllipsis(),
        ],
      ),
    );
  }
}

class _CircleOutlineIcon extends StatefulWidget {
  final IconData icon;
  const _CircleOutlineIcon({
    required this.icon,
  });

  @override
  State<_CircleOutlineIcon> createState() => _CircleOutlineIconState();
}

class _CircleOutlineIconState extends State<_CircleOutlineIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final baseBorder = const Color(0xFF7D7D7D).withValues(alpha: 0.55);
    final hoverBorder = const Color(0xFF5A5A5A);
    final baseIcon = const Color(0xFF7D7D7D).withValues(alpha: 0.55);
    final hoverIcon = const Color(0xFF2B2B2B);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
  height: 38,
  width: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _hover ? hoverBorder : baseBorder,
            width: 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          widget.icon,
          size: 18,
          color: _hover ? hoverIcon : baseIcon,
        ),
      ),
    );
  }
}

class _CircleOutlineEllipsis extends StatefulWidget {
  const _CircleOutlineEllipsis();
  @override
  State<_CircleOutlineEllipsis> createState() => _CircleOutlineEllipsisState();
}

class _CircleOutlineEllipsisState extends State<_CircleOutlineEllipsis> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final base = const Color(0xFF7D7D7D).withValues(alpha: 0.55);
    final hover = const Color(0xFF2B2B2B);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 160),
        style: TextStyle(
          color: _hover ? hover : base,
          fontSize: 26,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
        child: const Text('...'),
      ),
    );
  }
}

// --- Text Links Row (Twitter Facebook Instagram Mastodon) ---
class _ArchiveFooterLinks extends StatelessWidget {
  const _ArchiveFooterLinks();
  @override
  Widget build(BuildContext context) {
    const items = ['Twitter', 'Facebook', 'Instagram', 'Mastodon'];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 44,
      children: items.map((t) => _FadeFooterLink(label: t)).toList(),
    );
  }
}

// --- Legal Line ---
class _ArchiveLegalLine extends StatelessWidget {
  const _ArchiveLegalLine();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: const [
        _FooterMuted('© 2012-2024 Michael Xander and Benjamin Spall'),
        _FooterDot(),
        _FadeFooterLink(label: 'Legal'),
        _FooterDot(),
        _FadeFooterLink(label: 'Privacy'),
      ],
    );
  }
}

// --- Shared footer text/link widgets ---
class _FadeFooterLink extends StatefulWidget {
  final String label;
  const _FadeFooterLink({
    required this.label,
  });
  @override
  State<_FadeFooterLink> createState() => _FadeFooterLinkState();
}

class _FadeFooterLinkState extends State<_FadeFooterLink> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final base = const Color(0xFF7D7D7D).withValues(alpha: 0.62);
    final hover = const Color(0xFF1F1F1F);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 160),
        style: TextStyle(
          color: _hover ? hover : base,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        child: Text(widget.label),
      ),
    );
  }
}

class _FooterMuted extends StatelessWidget {
  final String text;
  const _FooterMuted(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF9A9A9A),
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _FooterDot extends StatelessWidget {
  const _FooterDot();
  @override
  Widget build(BuildContext context) => const Text(
        '·',
        style: TextStyle(
          color: Color(0xFF9A9A9A),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      );
}
