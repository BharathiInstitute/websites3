import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionsAnswersPage extends StatelessWidget {
  const QuestionsAnswersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 860;
    final heroHeight = isNarrow ? 300.0 : 400.0;
    // Brand (logo + text) controls (renamed: no leading underscore per lint)
    const double logoSize = 40;            // Adjust logo size here
    const double logoRadius = 23;          // Use logoSize/2 for perfect circle
    const double logoOffsetX = 280;        // Fine horizontal shift (positive -> right)
    const double logoOffsetY = 0;          // Fine vertical shift (negative -> up)

    // Navigation cluster controls
    const double navOffsetX = 0;           // Move entire nav group horizontally
    const double navOffsetY = 0;           // Move entire nav group vertically
    const double navSpacing = 22;          // Space between nav items
    const double navRightPadding = 50;     // Extra padding on the right edge

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO SECTION
            SizedBox(
              height: heroHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/1.png', fit: BoxFit.cover), // background hero image
                  Container( // dark overlay for readability
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: .55),
                          Colors.black.withValues(alpha: .55),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Row(
                          children: [
                            // Brand cluster LEFT (logo + text)
                            Transform.translate(
                              offset: const Offset(logoOffsetX, logoOffsetY),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(logoRadius),
                                    child: Image.asset(
                                      'assets/20.png',
                                      width: logoSize,
                                      height: logoSize,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const _HeroNavText('My Morning Routine', bold: true),
                                ],
                              ),
                            ),
                            const Spacer(),
                            // Navigation RIGHT (with adjustable offsets & spacing + More dropdown icon)
                            Padding(
                              padding: EdgeInsets.only(right: navRightPadding),
                              child: Transform.translate(
                                offset: const Offset(navOffsetX, navOffsetY),
                                child: Wrap(
                                  spacing: navSpacing,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    _HeroNavText('Routines'),
                                    _HeroNavText('Book'),
                                    _HeroNavText('Stats'),
                                    _HeroNavText('About'),
                                    _NavMore(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Title centered
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Questions & Answers',
                          style: TextStyle(
                            fontSize: isNarrow ? 50 : 66,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.05,
                            letterSpacing: .5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // CTA BANNER (black bar) below hero
            _CtaBanner(isNarrow: isNarrow),
            // Main body content
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 100),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760), // was 1020
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // center
                    children: [
                      Text(
                        'Publishing a brand new morning routine every week for over six years allowed us to create an exciting, ever-expanding collection of questions and answers from inspiring individuals living all over the world.',
                        style: TextStyle(
                          fontSize: isNarrow ? 15 : 16.5,
                          height: 1.55,
                          color: Colors.black.withValues(alpha: .82),
                          fontWeight: FontWeight.w400,
                          letterSpacing: .15,
                        ),
                        textAlign: TextAlign.center, // changed
                        strutStyle: const StrutStyle(height: 1.55, forceStrutHeight: true),
                      ),
                      const SizedBox(height: 34),
                      Text(
                        'Choose a question below to get started:',
                        style: TextStyle(
                          fontSize: isNarrow ? 15 : 16,
                          height: 1.5,
                          color: Colors.black.withValues(alpha: .82),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center, // changed
                      ),
                      const SizedBox(height: 42),
                      _QuestionList(isNarrow: isNarrow),
                      const SizedBox(height: 54),
                      const _SocialLinksRow(),
                      const SizedBox(height: 42),
                      const FooterSection(
                        endYear: 2024,
                        padding: EdgeInsets.fromLTRB(16, 32, 16, 64),
                        linkFontSize: 16,
                        legalFontSize: 14,
                        backgroundColor: Color(0xFFF7F7F7),
                        baseColor: Color(0xFF8A8A8A),
                        hoverColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CtaBanner extends StatefulWidget {
  final bool isNarrow;
  const _CtaBanner({required this.isNarrow});
  @override
  State<_CtaBanner> createState() => _CtaBannerState();
}

class _CtaBannerState extends State<_CtaBanner> {
  bool _dismissed = false;
  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();
    // Adjust these constants to fine‑tune positioning & size
  const double wideLeftOffset = 140; // desktop left shift (moved further right)
  const double narrowLeftOffset = 28; // mobile/tablet left shift (slightly more to the right)
    const double wideFontSize = 17; // desktop font size
    const double narrowFontSize = 16.5; // mobile font size

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: widget.isNarrow ? 20 : 70,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1250),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const double maxTextWidthWide = 900; // widen so sentence stays on one line (adjust as needed)
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.isNarrow ? constraints.maxWidth : maxTextWidthWide,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: widget.isNarrow ? narrowLeftOffset : wideLeftOffset,
                        right: 8, // small internal padding after text block
                      ),
                      child: Text(
                        'Our book is available to buy online or from your local bookstore!',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .92),
                          fontSize: widget.isNarrow ? narrowFontSize : wideFontSize,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                          letterSpacing: .2,
                        ),
                      ),
                    ),
                  ),
                ),
                if (!widget.isNarrow) ...[
                  const Spacer(), // push button cluster fully to the right
                  _PrimaryButton(
                    label: 'Learn More',
                    onTap: () {},
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () => setState(() => _dismissed = true),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(Icons.close, size: 18, color: Colors.white.withValues(alpha: .85)),
                    ),
                  ),
                ] else ...[
                  const Spacer(),
                  InkWell(
                    onTap: () => setState(() => _dismissed = true),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(Icons.close, size: 18, color: Colors.white.withValues(alpha: .85)),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});
  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
          decoration: BoxDecoration(
            color: _hover ? const Color(0xFFE86D00) : const Color(0xFFff7a00),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: .3,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionList extends StatelessWidget {
  final bool isNarrow;
  const _QuestionList({required this.isNarrow});

  List<Map<String, dynamic>> get _items => const [
    {'q': 'What is your morning routine?', 'rank': 1, 'answers': 341},
    {'q': 'How long have you stuck with your morning routine?', 'rank': 2, 'answers': 300},
    {'q': 'How has your morning routine changed over recent years?', 'rank': 3, 'answers': 288},
    {'q': 'What time do you go to sleep?', 'rank': 4, 'answers': 325},
    {'q': 'Do you do anything before going to bed to make your morning easier?', 'rank': 5, 'answers': 191},
    {'q': 'Do you use an alarm to wake up in the morning, and if so do you ever hit snooze button?', 'rank': 6, 'answers': 302},
    {'q': 'How soon after waking do you have breakfast, and what do you typically have?', 'rank': 7, 'answers': 311},
    {'q': 'do you have a morning workout routine?', 'rank': 8, 'answers': 284},
    {'q': 'Do you have a morning meditation routine?', 'rank': 9, 'answers': 226},
    {'q': 'Do you answer email first thing in the morning or leave it until later in the day?', 'rank': 10, 'answers': 304},
    {'q': 'Do you use any apps or products to enhance your sleep or morning routine?', 'rank': 11, 'answers': 162},
    {'q': 'How soon do you check your phone in the morning?', 'rank': 12, 'answers': 262},
    {'q': 'What are you most important tasks in the morning?', 'rank': 13, 'answers': 257},
    {'q': 'What and when is your first drink in the morning?', 'rank': 14, 'answers': 273},
    {'q': 'How does your partner fit into your morning routine?', 'rank': 15, 'answers': 94},
    {'q': 'Do you also follow your morning routine on weekends, or do you change some steps?', 'rank': 16, 'answers': 218},
    {'q': "On days you're not settled in your home, are you able to adapt your morning routine to fit in with a different environment?", 'rank': 17, 'answers': 299},
    {'q': 'What do you do if you fail to follow your morning routine, and how does this influence the rest of your day?', 'rank': 18, 'answers': 299},
  ];

  @override
  Widget build(BuildContext context) {
    // Fixed uniform width so every tile lines up (no stagger)
    final double maxWidth = isNarrow ? 600 : 860;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // stretch children full width
          children: [
            for (final m in _items) ...[
              _QuestionTile(
                question: m['q'] as String,
                rank: m['rank'] as int,
                answers: m['answers'] as int,
                isNarrow: isNarrow,
                onTap: () {},
              ),
              const SizedBox(height: 26),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuestionTile extends StatefulWidget {
  final String question;
  final int rank;
  final int answers;
  final bool isNarrow;
  final VoidCallback onTap;
  const _QuestionTile({
    required this.question,
    required this.rank,
    required this.answers,
    required this.isNarrow,
    required this.onTap,
  });

  @override
  State<_QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<_QuestionTile> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final baseBorder = Colors.grey.shade300;
    final hoverBg = const Color(0xFFFFF8F2);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          width: double.infinity, // force full available width
          duration: const Duration(milliseconds: 140),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isNarrow ? 18 : 24,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: _hover ? hoverBg : Colors.white,
            border: Border.all(
              color: _hover ? const Color(0xFFFF7A00) : baseBorder,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 140),
                style: TextStyle(
                  fontSize: widget.isNarrow ? 15.5 : 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF7A00),
                  letterSpacing: .15,
                ),
                child: Text(widget.question),
              ),
              const SizedBox(height: 10),
              Text(
                '#${widget.rank} - ${widget.answers} answers',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.2,
                  color: Colors.black.withValues(alpha: .55),
                  fontWeight: FontWeight.w400,
                  letterSpacing: .2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroNavText extends StatefulWidget {
  final String text;
  final bool bold;
  const _HeroNavText(this.text, {this.bold = false});
  @override
  State<_HeroNavText> createState() => _HeroNavTextState();
}

class _HeroNavTextState extends State<_HeroNavText> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 140),
        style: TextStyle(
          color: Colors.white.withValues(alpha: _hover ? 1 : 0.85),
          fontSize: 16,
          fontWeight: widget.bold ? FontWeight.w700 : FontWeight.w600,
        ),
        child: Text(widget.text),
      ),
    );
  }
}

class _NavMore extends StatefulWidget {
  const _NavMore();
  @override
  State<_NavMore> createState() => _NavMoreState();
}

class _NavMoreState extends State<_NavMore> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 140),
        style: TextStyle(
          color: Colors.white.withValues(alpha: _hover ? 1 : 0.85),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('More'),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.white.withValues(alpha: _hover ? 1 : 0.85),
            ),
          ],
        ),
      ),
    );
  }
}

// Compact social media icon row (requested) shown above the footer.
// Uses subtle fade-to-black on hover similar to link behavior, with equal spacing.
class _SocialLinksRow extends StatelessWidget {
  const _SocialLinksRow();
  @override
  Widget build(BuildContext context) {
    // Centered Wrap so it looks consistent on narrow / wide screens.
    return Center(
      child: Wrap(
        spacing: 34,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: const [
          _HoverFadeIcon(icon: FontAwesomeIcons.xTwitter, label: 'X'),
          _HoverFadeIcon(icon: FontAwesomeIcons.squareFacebook, label: 'Facebook'),
          _HoverFadeIcon(icon: FontAwesomeIcons.ellipsis, label: 'More'),
        ],
      ),
    );
  }
}

class _HoverFadeIcon extends StatefulWidget {
  final IconData icon;
  final String label; // used for semantics / potential tooltip
  const _HoverFadeIcon({required this.icon, required this.label});

  @override
  State<_HoverFadeIcon> createState() => _HoverFadeIconState();
}

class _HoverFadeIconState extends State<_HoverFadeIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final Color base = const Color(0xFF9A9A9A);
    final Color hover = const Color.fromARGB(255, 13, 13, 13);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(4),
        child: Icon(
          widget.icon,
          size: 20,
          color: _hover ? hover : base,
          semanticLabel: widget.label,
        ),
      ),
    );
  }
}

// ----- Re-added FooterSection (exact as requested) -----

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


