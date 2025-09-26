import 'package:flutter/material.dart';
import '../sections/footer.dart';

/// Routines page using the same hero + grid structure pattern shown in MorningProductsPage
/// but customized for "Routines" content. This page is navigated to ONLY from the Home page
/// top nav according to your requirement.
class RoutinesPage extends StatefulWidget {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _moreKey = GlobalKey();
  double? _menuLeft;
  double? _menuTop;
  bool _moreOpen = false;
  bool _showPromo = true; // controls visibility of the bottom promo bar

  void _onMenuTap(String label) {
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
                  Container(color: Colors.black.withOpacity(0.60)),
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
                                // Nav Links (non-functional here per requirement)
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
                              'Inspiring morning routines for a more productive and enjoyable day',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isNarrow ? 40 : 64,
                                fontWeight: FontWeight.w700,
                                height: 1.05,
                                letterSpacing: .5,
                                shadows: const [
                                  Shadow(color: Color.fromARGB(137, 0, 0, 0), blurRadius: 8, offset: Offset(0, 2)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom promo bar like screenshot_18
                  if (_showPromo)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: isNarrow ? 16 : 24, vertical: 18),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Our book is available to buy online or from your local bookstore!',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.85),
                                      fontSize: isNarrow ? 14 : 16,
                                      height: 1.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // CTA styled like screenshot
                                FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                                        return const Color(0xFFF07B26); // slightly lighter on hover
                                      }
                                      return const Color(0xFFE86F16);
                                    }),
                                    foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
                                    padding: WidgetStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        horizontal: isNarrow ? 18 : 22,
                                        vertical: isNarrow ? 10 : 12,
                                      ),
                                    ),
                                    shape: WidgetStatePropertyAll<OutlinedBorder>(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    ),
                                    textStyle: const WidgetStatePropertyAll<TextStyle>(
                                      TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                    elevation: const WidgetStatePropertyAll<double>(0),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Learn More'),
                                ),
                                const SizedBox(width: 20),
                                // Close icon (smaller, lighter)
                                IconButton(
                                  tooltip: 'Dismiss',
                                  icon: const Icon(Icons.close, color: Colors.white60, size: 18),
                                  style: IconButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    minimumSize: const Size(36, 36),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () => setState(() => _showPromo = false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (_moreOpen)
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() => _moreOpen = false),
                        child: const SizedBox.shrink(),
                      ),
                    ),
                  if (_moreOpen)
                    Positioned(
                      left: _menuLeft ?? 0,
                      top: _menuTop ?? 68,
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                                    color: Colors.black.withOpacity(0.10),
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

            // Below hero: Categories + Intro + Featured card
            Padding(
              padding: EdgeInsets.fromLTRB(16, _showPromo ? 40 : 56, 16, 80),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool narrow = constraints.maxWidth < 980;
                      final categories = const [
                        ('All Routines', 341),
                        ('Early Risers', 227),
                        ('Morning Exercise', 177),
                        ('Entrepreneurs', 171),
                        ('Writers', 145),
                        ('Full-Time Jobs', 133),
                        ('Yoga and Meditation', 129),
                        ('Parents', 91),
                        ('Frequent Travelers', 80),
                        ('Late Risers', 25),
                      ];

                      Widget left = SizedBox(
                        width: narrow ? constraints.maxWidth : 360,
                        child: Column(
                          children: [
                            _CategoriesPane(
                              items: categories,
                              total: 341,
                              selectedIndex: 0,
                            ),
                            const SizedBox(height: 8),
                            const _SortDropdownTile(label: 'Sort by Date'),
                            const SizedBox(height: 12),
                            const _SearchFieldBox(hintText: 'Search'),
                          ],
                        ),
                      );

                      Widget right = Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: narrow ? 0 : 16, right: 8, bottom: 18),
                              child: Text(
                                "Below you'll find our online archive of 341 morning routine interviews with bestselling authors, successful entrepreneurs, and inspiring creatives living all over the world.",
                                style: TextStyle(
                                  color: const Color(0xFF4A4A4A),
                                  fontSize: narrow ? 15.5 : 17,
                                  height: 1.55,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: narrow ? 0 : 16, right: 8, bottom: 22),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: const Color(0xFF4A4A4A),
                                    fontSize: narrow ? 15.5 : 17,
                                    height: 1.55,
                                  ),
                                  children: const [
                                    TextSpan(text: 'Browse our entire online archive of morning routines by selecting a category, using the search box, or reading a '),
                                    TextSpan(
                                      text: 'random routine',
                                      style: TextStyle(color: Color(0xFFE86F16), fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/16.png',
                              title: 'Julien Smith',
                              description:
                                  'Julien Smith is the co-founder and CEO of Practice, a business management platform for coaches, the author of The Flinch and Trust Agents, and a long-time blogger. He currently lives in Montréal, Canada.',
                              chips: const ['08:00AM', '10:00PM', '10:00h zZz'],
                              greyscaleOnHover: false,
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/17.png',
                              title: 'John Zeratsky',
                              description:
                                  'John Zeratsky is a writer and designer on a mission to help people make time for what matters. He is the author of Make Time: How to Focus on What Matters Every Day. He currently lives in Milwaukee, Wisconsin.',
                              chips: const ['06:30AM', '10:00PM', '08:30h zZz', '228 Months'],
                              greyAmount: 0.6,
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/18.png',
                              title: 'Kate Nafisi',
                              description:
                                  'Kate Nafisi is a designer and finisher at Nafisi Studio, a bespoke furniture and sculpture studio that she runs with her husband, Abi. Prior to working in the studio Kate had a decade-long career as a software designer. She currently lives in Horsham, UK.',
                              chips: const ['06:00AM', '10:00PM', '08:00h zZz', '6 Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/19.png',
                              title: 'Wilf Richards',
                              description:
                                  'Wilf Richards is a co‑founder of Abundant Earth, a workers’ coop that runs courses and produces craft goods and food. He lives in Durham, UK.',
                              chips: const ['07:00AM', '10:00PM', '09:00h zZz', '18 Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/21.png',
                              title: 'Josh Gross',
                              description:
                                  'Josh Gross is a founding partner at Planetary, a digital product studio that has worked with many notable clients. He lives in New York City.',
                              chips: const ['07:00AM', '12:00AM', '07:00h zZz', '60 Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/22.png',
                              title: 'Melissa Clark',
                              description:
                                  'Melissa Clark is a food writer for The New York Times and the author of numerous cookbooks. She lives in Brooklyn.',
                              chips: const ['06:16AM', '11:15PM', '07:00h zZz', '60 Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/23.png',
                              title: 'Paul Murphy',
                              description:
                                  'Paul Murphy is a third‑grade teacher and writer focused on helping teachers in the classroom. He lives in Mason, Michigan with his family.',
                              chips: const ['05:45AM', '10:00PM', '07:30h zZz', '— Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/24.png',
                              title: 'Denise Lee',
                              description:
                                  'Denise Lee is the founder of Alala, a high‑end women’s activewear brand. She lives in New York City.',
                              chips: const ['06:15AM', '11:00PM', '07:15h zZz', '36 Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/25.png',
                              title: 'Amy Nelson',
                              description:
                                  'Amy Nelson is the founder and CEO of The Riveter, a community and co‑working space company built by women for everyone. She lives in Seattle, Washington.',
                              chips: const ['06:00AM', '10:30PM', '07:00h zZz', '— Months'],
                            ),
                            const SizedBox(height: 40),
                            _FeaturedRoutineCard(
                              imageAsset: 'assets/26.png',
                              title: 'Rick Smith',
                              description:
                                  'Rick Smith is the founder and CEO of Axon and author of The End of Killing. He lives in Scottsdale, Arizona.',
                              chips: const ['06:00AM', '11:00PM', '07:00h zZz', '9 Months'],
                            ),
                            const SizedBox(height: 36),
                            // Browse all bar with hover fade effect
                            Padding(
                              padding: EdgeInsets.only(left: narrow ? 0 : 16, right: 8),
                              child: const _BrowseAllBar(),
                            ),
                          ],
                        ),
                      );

                      if (narrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [left, const SizedBox(height: 24), right],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [left, const SizedBox(width: 24), right],
                      );
                    },
                  ),
                ),
              ),
            ),

            // Footer
            const SizedBox(height: 24),
            const FooterSection(
              padding: EdgeInsets.symmetric(vertical: 48),
              linkFontSize: 16,
              legalFontSize: 14,
              backgroundColor: Color(0xFFF5F5F5),
              endYear: 2024,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox.shrink(),
    );
  }
}

class _HoverFadeText extends StatefulWidget {
  const _HoverFadeText({
    required this.label,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.baseColor = Colors.white,
    this.normalOpacity = 0.85,
    this.hoverOpacity = 1.0,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color baseColor;
  final double normalOpacity;
  final double hoverOpacity;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  State<_HoverFadeText> createState() => _HoverFadeTextState();
}

class _HoverFadeTextState extends State<_HoverFadeText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final text = AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 150),
      style: TextStyle(
        color: widget.baseColor.withOpacity(_hovering ? widget.hoverOpacity : widget.normalOpacity),
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
      child: Padding(
        padding: widget.padding,
        child: Text(widget.label),
      ),
    );

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: widget.onTap != null
          ? GestureDetector(behavior: HitTestBehavior.opaque, onTap: widget.onTap, child: text)
          : text,
    );
  }
}

Widget _navLink(String label, {required VoidCallback onTap}) {
  return _HoverFadeText(
    label: label,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    onTap: onTap,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    baseColor: Colors.white,
    normalOpacity: 0.85,
    hoverOpacity: 1.0,
  );
}

class _MenuItem extends StatefulWidget {
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;
  const _MenuItem({required this.label, required this.onTap, this.trailing});
  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        splashColor: const Color(0xFFE86F16).withOpacity(.06),
        highlightColor: Colors.transparent,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: _hover ? const Color(0xFFF9742C) : const Color(0xFF555555),
                  ),
                ),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

// Removed _Pill widget since below-hero section was deleted

class _CategoriesPane extends StatelessWidget {
  const _CategoriesPane({required this.items, required this.total, required this.selectedIndex});

  final List<(String, int)> items;
  final int total;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < items.length; i++)
          _CategoryTile(
            label: items[i].$1,
            count: items[i].$2,
            ratio: (items[i].$2 / total).clamp(0.0, 1.0),
            selected: i == selectedIndex,
          ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.count,
    required this.ratio,
    this.selected = false,
  });

  final String label;
  final int count;
  final double ratio;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFFF8EEE6) : const Color(0xFFF6F6F6);
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
                Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9A9A9A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, c) {
                return Stack(
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Container(
                      height: 4,
                      width: (c.maxWidth * ratio).clamp(0.0, c.maxWidth),
                      color: const Color(0xFFE86F16),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedRoutineCard extends StatefulWidget {
  const _FeaturedRoutineCard({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.chips,
    this.greyscaleOnHover = true,
    this.greyAmount = 0.6, // 0..1 how strong the greyscale gets on hover
  });

  final String imageAsset;
  final String title;
  final String description;
  final List<String> chips;
  final bool greyscaleOnHover;
  final double greyAmount;

  @override
  State<_FeaturedRoutineCard> createState() => _FeaturedRoutineCardState();
}

class _FeaturedRoutineCardState extends State<_FeaturedRoutineCard> {
  bool _hover = false;

  static const List<double> _identity = <double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ];
  static const List<double> _greyscale = <double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ];

  List<double> _lerpMatrix(List<double> a, List<double> b, double t) {
    return List<double>.generate(20, (i) => a[i] + (b[i] - a[i]) * t);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: widget.greyscaleOnHover ? (_hover ? widget.greyAmount.clamp(0.0, 1.0) : 0) : 0,
                ),
                builder: (context, t, child) {
                  final matrix = _lerpMatrix(_identity, _greyscale, t);
                  return ColorFiltered(
                    colorFilter: ColorFilter.matrix(matrix),
                    child: child,
                  );
                },
                child: Image.asset(widget.imageAsset, fit: BoxFit.cover),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x55000000),
                    Color(0x55000000),
                    Color(0xAA000000),
                  ],
                ),
              ),
            ),
            // Extra darken overlay on hover, to match screenshot_1 style
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 0, end: _hover ? 0.2 : 0), // 0.0..0.2 extra dark
                  builder: (context, o, _) => Container(color: Colors.black.withOpacity(o)),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.92),
                        fontSize: 16.5,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < widget.chips.length; i++) ...[
                          Container(
                            margin: EdgeInsets.only(right: i == widget.chips.length - 1 ? 0 : 10),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.35),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.chips[i],
                              style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.35),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.bookmark_border, color: Colors.white70, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrowseAllBar extends StatefulWidget {
  const _BrowseAllBar();

  @override
  State<_BrowseAllBar> createState() => _BrowseAllBarState();
}

class _BrowseAllBarState extends State<_BrowseAllBar> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _hover ? const Color(0xFFEAEAEA) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 160),
          style: TextStyle(
            color: _hover ? const Color(0xFF6F6F6F) : const Color.fromARGB(255, 98, 98, 98),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          child: const Text('Browse all 341 Morning Routines'),
        ),
      ),
    );
  }
}

class _SortDropdownTile extends StatefulWidget {
  const _SortDropdownTile({required this.label});
  final String label;

  @override
  State<_SortDropdownTile> createState() => _SortDropdownTileState();
}

class _SortDropdownTileState extends State<_SortDropdownTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final base = const Color(0xFFF0F0F0);
    final hover = const Color(0xFFE7E7E7);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer
        (
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: _hover ? hover : base,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: TextStyle(
                  color: const Color.fromARGB(255, 97, 96, 96).withOpacity(_hover ? 1.0 : 0.9),
                  fontWeight: FontWeight.w600,
                ),
                child: Text(widget.label),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFFC2C2C2)),
          ],
        ),
      ),
    );
  }
}

class _SearchFieldBox extends StatelessWidget {
  const _SearchFieldBox({this.hintText});
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              hintText ?? 'Search',
              style: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 15,
              ),
            ),
          ),
          const Icon(Icons.search, color: Color(0xFFBDBDBD)),
        ],
      ),
    );
  }
}
