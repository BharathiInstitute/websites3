import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MorningProductsPage extends StatefulWidget {
  const MorningProductsPage({super.key});

  @override
  State<MorningProductsPage> createState() => _MorningProductsPageState();
}

class _MorningProductsPageState extends State<MorningProductsPage> {
  // State & keys for upcoming dropdown/menu logic
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _moreKey = GlobalKey();
  double? _menuLeft;
  double? _menuTop;
  bool _moreOpen = false;

  void _onMenuTap(String label) {
    // Placeholder for navigation or actions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tapped: $label')),
    );
    setState(() => _moreOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isNarrow = size.width < 700;
    final double heroHeight = isNarrow ? 320 : 480;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HERO
            SizedBox(
              height: heroHeight,
              child: Stack(
                key: _stackKey,
                fit: StackFit.expand,
                children: [
                  // Background image
                  Image.asset(
                    'assets/1.png',
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withValues(alpha: 0.60)),
                  // Top Navigation Bar
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
                                  children: [
                                    Container(
                                      width: 34,
                                      height: 34,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE86F16),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.local_cafe, color: Colors.white, size: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    _HoverFadeText(
                                      label: 'My Morning Routine',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      baseColor: Colors.white,
                                      normalOpacity: 0.9,
                                      hoverOpacity: 1.0,
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                                    ),
                                  ],
                                ),
                                // Nav Links
                                Wrap(
                                  alignment: WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 2,
                                  children: [
                                    _navLink('Routines', onTap: () {}),
                                    _navLink('Book', onTap: () {}),
                                    _navLink('Stats', onTap: () {}),
                                    _navLink('About', onTap: () {}),
                                    KeyedSubtree(
                                      key: _moreKey,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          final moreBox = _moreKey.currentContext?.findRenderObject() as RenderBox?;
                                          final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
                                          if (moreBox != null && stackBox != null) {
                                            final morePos = moreBox.localToGlobal(Offset.zero);
                                            final stackPos = stackBox.localToGlobal(Offset.zero);
                                            const menuWidth = 220.0;
                                            final stackWidth = stackBox.size.width;
                                            final left = morePos.dx - stackPos.dx + (moreBox.size.width / 2) - (menuWidth / 2);
                                            _menuLeft = left.clamp(8.0, stackWidth - menuWidth - 8.0);
                                            _menuTop = morePos.dy - stackPos.dy + moreBox.size.height + 8;
                                          }
                                          setState(() => _moreOpen = !_moreOpen);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _navLink('More', onTap: () {
                                              final moreBox = _moreKey.currentContext?.findRenderObject() as RenderBox?;
                                              final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
                                              if (moreBox != null && stackBox != null) {
                                                final morePos = moreBox.localToGlobal(Offset.zero);
                                                final stackPos = stackBox.localToGlobal(Offset.zero);
                                                const menuWidth = 220.0;
                                                final stackWidth = stackBox.size.width;
                                                final left = morePos.dx - stackPos.dx + (moreBox.size.width / 2) - (menuWidth / 2);
                                                _menuLeft = left.clamp(8.0, stackWidth - menuWidth - 8.0);
                                                _menuTop = morePos.dy - stackPos.dy + moreBox.size.height + 8;
                                              }
                                              setState(() => _moreOpen = !_moreOpen);
                                            }),
                                            Icon(
                                              _moreOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 18,
                                            ),
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
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Morning Products',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isNarrow ? 48 : 84,
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
                                'This is our frequently-updated collection of the best coffee makers, apps, and other products to help create your perfect morning routine. Start by selecting a category below or check out this week\'s picks.',
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

            // Insert new content below hero
            buildBelowHero(isNarrow),
          ],
        ),
      ),
    );
  }
}
// ------------------------------------------------------------
// CONTENT BELOW HERO
// ------------------------------------------------------------

extension on _MorningProductsPageState {
  Widget buildBelowHero(bool isNarrow) {
    return Column(
      children: [
        const SizedBox(height: 34),
        const _CategoryTileButtons(),
        const SizedBox(height: 110),
        const _SectionHeading(
          title: "This Week's Picks",
          subtitle:
              'Our top picks this week of the morning products that we believe are most worth your time.',
        ),
        const SizedBox(height: 40),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _ProductGrid(products: sampleProducts),
          ),
        ),
        const SizedBox(height: 160),
        // Books and More Section
        const _BooksAndMoreSection(),
        const SizedBox(height: 160),
        // Inline footer (moved from footer.dart per request)
        const _PageFooter(),
      ],
    );
  }
}

// Category tile style buttons (6 tiles) like screenshot
class _CategoryTileButtons extends StatefulWidget {
  const _CategoryTileButtons();
  @override
  State<_CategoryTileButtons> createState() => _CategoryTileButtonsState();
}

class _CategoryTileButtonsState extends State<_CategoryTileButtons> {
  final List<String> categories = const [
    'Health and Fitness',
    'Coffees and Coffeeware',
    'Teas and Teaware',
    'Kitchen Utensils',
    'Sleep Accessories',
    'Apps',
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1060;
        final containerWidth = isWide ? 1280.0 : constraints.maxWidth;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: containerWidth),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 46,
              runSpacing: 32,
              children: [
                for (final c in categories)
                  _CategoryTileButton(label: c),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryTileButton extends StatefulWidget {
  final String label;
  const _CategoryTileButton({required this.label});
  @override
  State<_CategoryTileButton> createState() => _CategoryTileButtonState();
}

class _CategoryTileButtonState extends State<_CategoryTileButton> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOut,
          width: 250,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            border: const Border(
              top: BorderSide(color: Color(0xFFEFEFEF), width: 1),
              left: BorderSide(color: Color(0xFFEDEDED), width: 1),
              right: BorderSide(color: Color(0xFFEDEDED), width: 1),
              bottom: BorderSide(color: Color(0xFFE2E2E2), width: 3),
            ),
            boxShadow: [
              if (_hover)
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF202020).withOpacity(_hover ? 0.85 : 0.78),
                    letterSpacing: .2,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: 4,
                  child: Stack(
                    children: [
                      // Base thin grey line always visible
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 2,
                          color: const Color(0xFFE2E2E2),
                        ),
                      ),
                      // Orange hover/active overlay line
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          height: _hover ? 4 : 0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE86F16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SECTION HEADING
// ------------------------------------------------------------
class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeading({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.w700,
            color: Color(0xFF262626),
            height: 1.08,
            letterSpacing: .5,
          ),
        ),
        const SizedBox(height: 26),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 890),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xFF444444),
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// PRODUCT GRID & CARD
// ------------------------------------------------------------
class Product {
  final String name;
  final String subtitle;
  final String price; // current price
  final String? oldPrice;
  final String imageAsset; // use placeholder assets for now
  const Product({
    required this.name,
    required this.subtitle,
    required this.price,
    this.oldPrice,
    required this.imageAsset,
  });
}

const sampleProducts = <Product>[
  Product(
    name: 'Baratza Encore',
    subtitle: 'Great grinder for drip/manual',
    price: ' 149.95',
    imageAsset: 'assets/12.png',
  ),
  Product(
    name: 'Philips Hue Starter Kit',
    subtitle: 'Personal wireless lighting',
    price: ' 185.99',
    oldPrice: ' 199.99',
    imageAsset: 'assets/13.png',
  ),
  Product(
    name: 'Fitbit Flex 2',
    subtitle: 'Basic activity and sleep tracker',
    price: ' 109.98',
    oldPrice: ' 129.00',
    imageAsset: 'assets/14.png',
  ),
  Product(
    name: 'Hario Mizudashi Cold Coffee Brewer',
    subtitle: 'Smooth cold coffee at home',
    price: ' 20.50',
    oldPrice: ' 24.50',
    imageAsset: 'assets/15.png',
  ),
];

class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int cols = 1;
        if (width >= 1280) {
          cols = 5;
        } else if (width >= 1040) {
          cols = 4;
        } else if (width >= 820) {
          cols = 3;
        } else if (width >= 560) {
          cols = 2;
        }
        final gap = 26.0;
        final itemWidth = (width - (cols - 1) * gap) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final p in products)
              _ProductCard(product: p, width: itemWidth),
          ],
        );
      },
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Product product;
  final double width;
  const _ProductCard({required this.product, required this.width});
  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEDEDED)),
          boxShadow: [
            if (_hover)
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(p.imageAsset, fit: BoxFit.cover),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (p.oldPrice != null)
                    Row(
                      children: [
                        Text(
                          p.oldPrice!,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: const Color(0xFF2E2E2E).withValues(alpha: .45),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          p.price,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE86F16),
                            letterSpacing: .3,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      p.price,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3A3A3A),
                        letterSpacing: .3,
                      ),
                    ),
                  const SizedBox(height: 14),
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E1E1E),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                      color: const Color(0xFF454545).withValues(alpha: .85),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// _CategoryTile removed
// ------------------------------------------------------------
// NAV & MENU HELPERS
// ------------------------------------------------------------

// ------------------------------------------------------------
// BOOKS AND MORE SECTION
// ------------------------------------------------------------
class _BooksAndMoreSection extends StatelessWidget {
  const _BooksAndMoreSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Books and More',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 62,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D2D2D),
            height: 1.05,
            letterSpacing: .5,
          ),
        ),
        const SizedBox(height: 38),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: _BooksAndMoreRichText(),
        ),
        // Increased spacing between the description and the social icon row
        const SizedBox(height: 230),
        const _SocialLinksRow(),
        // Footer meta removed per user request
      ],
    );
  }
}

class _BooksAndMoreRichText extends StatefulWidget {
  @override
  State<_BooksAndMoreRichText> createState() => _BooksAndMoreRichTextState();
}

class _BooksAndMoreRichTextState extends State<_BooksAndMoreRichText> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final baseStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFF2E2E2E),
      height: 1.55,
      letterSpacing: .2,
    );
    final linkColor = _hover ? const Color.fromARGB(255, 238, 171, 123) : const Color(0xFFE86F16);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Library link tapped')),
          );
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeInOut,
          opacity: _hover ? 0.65 : 1.0, // subtle fade on entire sentence
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: baseStyle,
              children: [
                const TextSpan(text: 'Looking for something to read, watch, or listen to? '),
                TextSpan(
                  text: 'Check out our library',
                  style: baseStyle.copyWith(
                    color: linkColor,
                    decoration: TextDecoration.underline,
                    decorationColor: linkColor,
                    fontWeight: FontWeight.w700,
                    // individual word fade emphasis
                  ),
                ),
                const TextSpan(text: ' of the best books, talks, podcasts, and\narticles around to help create your perfect morning routine.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SOCIAL LINKS ROW
// ------------------------------------------------------------
class _SocialLinksRow extends StatelessWidget {
  const _SocialLinksRow();
  @override
  Widget build(BuildContext context) {
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
  final String label;
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

Widget _navLink(String label, {required VoidCallback onTap}) {
  return _HoverFadeText(
    label: label,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    baseColor: Colors.white,
    normalOpacity: 0.78,
    hoverOpacity: 1.0,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    onTap: onTap,
  );
}

class _HoverFadeText extends StatefulWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color baseColor;
  final double normalOpacity;
  final double hoverOpacity;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  const _HoverFadeText({
    required this.label,
    required this.fontSize,
    required this.fontWeight,
    required this.baseColor,
    required this.normalOpacity,
    required this.hoverOpacity,
    required this.padding,
    this.onTap,
  });
  @override
  State<_HoverFadeText> createState() => _HoverFadeTextState();
}

class _HoverFadeTextState extends State<_HoverFadeText> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final child = AnimatedDefaultTextStyle(
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
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Padding(
          padding: widget.padding,
          child: child,
        ),
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  const _MenuItem({required this.label, required this.onTap, this.trailing});
  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final bgColor = _hover ? const Color(0xFFF3F3F3) : Colors.white; // match hover screenshot
  // Highlight every item in orange on hover (not just Library)
  final bool highlightOrange = _hover;
    final textColor = highlightOrange
        ? const Color(0xFFE86F16)
  : const Color(0xFF111111).withValues(alpha: _hover ? 0.95 : 0.80);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: bgColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 140),
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
                child: Text(widget.label),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// INLINE FOOTER (prices line, social text links, copyright/legal)
// ------------------------------------------------------------
class _PageFooter extends StatelessWidget {
  const _PageFooter();
  @override
  Widget build(BuildContext context) {
    const Color grey = Color(0xFF9D9D9D);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 54, bottom: 90),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 241, 237, 237),
        border: Border(
          top: BorderSide(color: Color(0xFFEDEDED), width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Prices updated on Aug 17, 2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: grey,
                  letterSpacing: .25,
                ),
              ),
              SizedBox(height: 34),
              _FooterLinksRow(),
              SizedBox(height: 40),
              _FooterCopyrightRow(),
            ],
      ),
    );
  }
}

class _FooterLinksRow extends StatelessWidget {
  const _FooterLinksRow();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 46,
      children: const [
        _FooterHoverLink('Twitter', fontSize: 15),
        _FooterHoverLink('Facebook', fontSize: 15),
        _FooterHoverLink('Instagram', fontSize: 15),
        _FooterHoverLink('Mastodon', fontSize: 15),
      ],
    );
  }
}

class _FooterCopyrightRow extends StatelessWidget {
  const _FooterCopyrightRow();
  @override
  Widget build(BuildContext context) {
    const Color grey = Color(0xFF9D9D9D);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: const [
            Text(
              '© 2012-2024 Michael Xander and Benjamin Spall',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: grey,
                letterSpacing: .25,
              ),
            ),
            Text('·', style: TextStyle(fontSize: 15, color: grey)),
            _FooterHoverLink('Legal', fontSize: 15),
            Text('·', style: TextStyle(fontSize: 15, color: grey)),
            _FooterHoverLink('Privacy', fontSize: 15),
          ],
    );
  }
}

class _FooterHoverLink extends StatefulWidget {
  final String text;
  final double fontSize;
  const _FooterHoverLink(this.text, {this.fontSize = 15});
  @override
  State<_FooterHoverLink> createState() => _FooterHoverLinkState();
}

class _FooterHoverLinkState extends State<_FooterHoverLink> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    const base = Color(0xFF1B1B1B);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 140),
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: .3,
          color: base.withValues(alpha: _hover ? 0.85 : 0.55),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
