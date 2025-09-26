import 'package:flutter/material.dart';
import '../sections/book_promo_section.dart';
import '../content/buy_book.dart';
import '../logos/retailer_logos.dart';
import '../content/about_the_book.dart';
import '../widgets/hero_section.dart';
import '../sections/peek_inside.dart';
import '../sections/bloom_berg.dart';
// Footer import removed after footer section was deleted

/// Book page showing a hero with top bar, center content, 'More' dropdown, and the BookPromoSection.
class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  // Dropdown state for 'More'
  bool _moreOpen = false;
  double? _menuLeft;
  double? _menuTop;

  // Keys to compute dropdown absolute position relative to the hero stack
  final GlobalKey _heroStackKey = GlobalKey();
  final GlobalKey _moreKey = GlobalKey();

  void _onMenuTap(String label) {
    // On Book page, keep items display-only; just close the menu
    setState(() => _moreOpen = false);
  }

  void _toggleMoreMenu() {
    final stackBox = _heroStackKey.currentContext?.findRenderObject() as RenderBox?;
    final moreBox = _moreKey.currentContext?.findRenderObject() as RenderBox?;

    if (stackBox != null && moreBox != null) {
      final morePos = moreBox.localToGlobal(Offset.zero);
      final stackPos = stackBox.localToGlobal(Offset.zero);
      final relDx = morePos.dx - stackPos.dx;
      final relDy = morePos.dy - stackPos.dy;
      // Right-align the 220px menu to the 'More' row and place slightly below
      final menuWidth = 220.0;
      final left = relDx + moreBox.size.width - menuWidth;
      final top = relDy + moreBox.size.height + 8;
      setState(() {
        _menuLeft = left;
        _menuTop = top;
        _moreOpen = !_moreOpen;
      });
    } else {
      setState(() => _moreOpen = !_moreOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero section placed above the book promo section with a custom top navigation overlay
              HeroSection(
                viewportFraction: 0.5,
                showOverlayImage: false,
                showGradientOverlay: false,
                child: Stack(
                  key: _heroStackKey,
                  children: [
                    // Dark overlay over the image
                    Positioned.fill(
                      child: Container(color: Colors.black.withValues(alpha: 0.60)),
                    ),
                    // Top Navigation Bar (non-functional here per Home-only nav rule)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Logo + Brand
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      _BrandBubble(),
                                      SizedBox(width: 10),
                                      _HoverFadeText(
                                        label: 'My Morning Routine',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        baseColor: Colors.white,
                                        normalOpacity: 0.9,
                                        hoverOpacity: 1.0,
                                        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                                      ),
                                    ],
                                  ),
                                  // Nav Links (display only)
                                  Wrap(
                                    alignment: WrapAlignment.end,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 2,
                                    children: [
                                      _HoverFadeText(
                                        label: 'Routines',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        baseColor: Colors.white,
                                        normalOpacity: 0.78,
                                        hoverOpacity: 1.0,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      ),
                                      _HoverFadeText(
                                        label: 'Book',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        baseColor: Colors.white,
                                        normalOpacity: 0.78,
                                        hoverOpacity: 1.0,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      ),
                                      _HoverFadeText(
                                        label: 'Stats',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        baseColor: Colors.white,
                                        normalOpacity: 0.78,
                                        hoverOpacity: 1.0,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      ),
                                      _HoverFadeText(
                                        label: 'About',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        baseColor: Colors.white,
                                        normalOpacity: 0.78,
                                        hoverOpacity: 1.0,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      ),
                                      // "More" label with a static chevron
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                        child: GestureDetector(
                                          key: _moreKey,
                                          behavior: HitTestBehavior.opaque,
                                          onTap: _toggleMoreMenu,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              _HoverFadeText(
                                                label: 'More',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                baseColor: Colors.white,
                                                normalOpacity: 0.78,
                                                hoverOpacity: 1.0,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                              ),
                                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Centered heading + description inside the hero
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isNarrow = constraints.maxWidth < 900;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Meet our Book',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isNarrow ? 38 : 54,
                                      fontWeight: FontWeight.w700,
                                      height: 1.05,
                                      letterSpacing: .5,
                                      shadows: const [
                                        Shadow(color: Color.fromARGB(137, 0, 0, 0), blurRadius: 8, offset: Offset(0, 2)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 26),
                                  // Hero description text
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 1100),
                                    child: Text(
                                      "My Morning Routine: How Successful People Start Every Day Inspired",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: .90),
                                        fontSize: isNarrow ? 18 : 22,
                                        height: 1.55,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // Backdrop to close dropdown when clicking outside
                    if (_moreOpen)
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => setState(() => _moreOpen = false),
                          child: const SizedBox.shrink(),
                        ),
                      ),
                    // Dropdown menu for 'More'
                    if (_moreOpen)
                      Positioned(
                        left: _menuLeft ?? 0,
                        top: _menuTop ?? 68,
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Pointer arrow with subtle border
                              Transform.translate(
                                offset: const Offset(0, 6),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 14,
                                      height: 14,
                                      decoration: const BoxDecoration(color: Color(0xFFEDEDED)),
                                      transform: Matrix4.identity()..rotateZ(0.785398),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(color: Colors.white),
                                      transform: Matrix4.identity()..rotateZ(0.785398),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE86F16)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.10),
                                      blurRadius: 16,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _MenuItem(label: 'Q&A', onTap: () => _onMenuTap('Q&A')),
                                    _MenuItem(label: 'Quotes', onTap: () => _onMenuTap('Quotes')),
                                    _MenuItem(
                                      label: 'Deals',
                                      onTap: () => _onMenuTap('Deals'),
                                      trailing: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE86F16),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    _MenuItem(label: 'Products', onTap: () => _onMenuTap('Products')),
                                    _MenuItem(label: 'Library', onTap: () => _onMenuTap('Library')),
                                    _MenuItem(label: 'Articles', onTap: () => _onMenuTap('Articles')),
                                    _MenuItem(label: 'Press', onTap: () => _onMenuTap('Press')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Shift paragraph to the right specifically on the Book page
              // Promo section positioned per screenshot_9 (default sizing, no horizontal shift)
              // Raise book so top half overlaps hero, bottom half sits in promo
              const BookPromoSection(
                bookImageOffsetY: -160, // adjust overlap height as needed
              ),
              const SizedBox(height: 98),
              const BuyBookTitle(bottomPadding: 64),
              const BuyBookSubtext(topPadding: 16),
              const SizedBox(height: 32),
              const RetailerLogosBar(),
              const SizedBox(height: 60),
              // Hide social media icons specifically on the Book page per latest request
              const AboutTheBookTitle(showSocialIcons: false),
              const SizedBox(height: 60),
              // Animated fading social icons (Book page only) placed above Featured On text
              const SocialIconsFade(),
              const SizedBox(height: 48),
              // Featured On heading + description (Book page only)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Featured On',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .5,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                    SizedBox(height: 18),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Text(
                        'Publications we have written for, that have interviewed us, or that have written about our book and website:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.45,
                          color: Color(0xFF3A3A3A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 48),
                  ],
                ),
              ),
              // Image 27 placed directly below the social icons (which are the last
              // element inside AboutTheBookTitle). Only added on Book page per request.
              Center(
                child: Image.asset(
                  'assets/27.png',
                  width: 1300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 120),
              // Peek Inside section (added to Book page)
              const PeekInsideSection(
                headingFontSize: 64,
                bodyFontSize: 19,
                padding: EdgeInsets.symmetric(vertical: 40),
              ),
              const SizedBox(height: 140),
              // Bloomberg review quote card
              const BloombergReviewQuote(
                padding: EdgeInsets.symmetric(vertical: 24),
                quoteFontSize: 18,
                attributionFontSize: 16,
              ),
              const SizedBox(height: 100),
              // Translations section (Book page only)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Translations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .4,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(height: 18),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 960),
                      child: const Text(
                        'Alongside English, My Morning Routine is currently available in Chinese (Complex), Chinese (Simplified), German, and Russian. It is soon to be published in Arabic, Azerbaijani, Korean, Vietnamese, and more.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          height: 1.55,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              // Why a Book section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Why a Book?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .4,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(height: 26),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 960),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'The book isn’t just a collection of interviews, but instead an inspiring instruction manual that will show you how to get into a routine that works for you. We cover everything from how to add elements such as working out, meditation, and unintimidating self-care rituals to your routine, to how parents can adjust their routine to fit in with the needs of their kids, to how to stick to your morning routine over the long haul.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 19,
                              height: 1.55,
                              color: Color(0xFF2F2F2F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 28),
                          Text(
                            'The book also includes exclusive interviews with a cast of high-profile names, including Pixar’s Ed Catmull, three-time Olympic gold medalist Rebecca Soni, and the first woman to head a Hollywood movie studio, Sherry Lansing, to name but a few.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 19,
                              height: 1.55,
                              color: Color(0xFF2F2F2F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Footer removed per latest request
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandBubble extends StatelessWidget {
  const _BrandBubble();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        color: Color(0xFFE86F16),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.local_cafe, color: Colors.white, size: 18),
    );
  }
}

class _HoverFadeText extends StatefulWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color baseColor;
  final double normalOpacity;
  final double hoverOpacity;
  final EdgeInsetsGeometry padding;

  const _HoverFadeText({
    required this.label,
    required this.fontSize,
    required this.fontWeight,
    required this.baseColor,
    required this.normalOpacity,
    required this.hoverOpacity,
    required this.padding,
  });
  @override
  State<_HoverFadeText> createState() => _HoverFadeTextState();
}

// Animated sequential fade-in social icons row (Book page only usage)
class SocialIconsFade extends StatefulWidget {
  const SocialIconsFade({super.key});

  @override
  State<SocialIconsFade> createState() => _SocialIconsFadeState();
}

class _SocialIconsFadeState extends State<SocialIconsFade> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade1;
  late final Animation<double> _fade2;
  late final Animation<double> _fade3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    _fade1 = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeIn));
    _fade2 = CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeIn));
    _fade3 = CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFadeIcon(Widget icon, Animation<double> animation) => FadeTransition(opacity: animation, child: icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFadeIcon(const Icon(Icons.close, // Using close to approximate X (Twitter rebrand) without FontAwesome
            color: Colors.grey, size: 28), _fade1),
        const SizedBox(width: 20),
        _buildFadeIcon(const Icon(Icons.facebook, color: Colors.grey, size: 28), _fade2),
        const SizedBox(width: 20),
        _buildFadeIcon(const Icon(Icons.more_horiz, color: Colors.grey, size: 28), _fade3),
      ],
    );
  }
}

class _HoverFadeTextState extends State<_HoverFadeText> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final text = AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 140),
      style: TextStyle(
        color: widget.baseColor.withValues(alpha: _hover ? widget.hoverOpacity : widget.normalOpacity),
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        letterSpacing: .3,
      ),
      child: Text(widget.label),
    );
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Padding(padding: widget.padding, child: text),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  const _MenuItem({
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

// (Removed inline _SocialIconsRow per latest request.)
