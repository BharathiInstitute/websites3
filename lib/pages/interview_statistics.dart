import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterviewStatisticsPage extends StatefulWidget {
  const InterviewStatisticsPage({super.key});

  @override
  State<InterviewStatisticsPage> createState() => _InterviewStatisticsPageState();
}

class _InterviewStatisticsPageState extends State<InterviewStatisticsPage> {
  bool _showPromo = true;
  bool _moreOpen = false;
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _moreKey = GlobalKey();
  double? _menuLeft;
  double? _menuTop;
  // Navigation to Q&A is intentionally disabled until you decide to enable it.
  // Flip this to true (and re-import question_answer.dart) when you want the menu
  // item to actually open the Q&A page.
  final bool _qaNavEnabled = false;

  Widget _navLink(String label, {VoidCallback? onTap}) => _HoverFadeText(
        label: label,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        baseColor: Colors.white,
        normalOpacity: 0.85,
        hoverOpacity: 1.0,
      );

  void _onMenuTap(String item) {
    setState(() => _moreOpen = false);
    if (item == 'Q&A') {
      if (!_qaNavEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Q&A page coming soon.'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return; // Do not navigate
      }
      // When enabling, uncomment the navigation below AND add:
      // import 'question_answer.dart';
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) => const QAPage()),
      // );
      return; // (Currently inert)
    }
    // Placeholder: keep SnackBar for other items until implemented
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Clicked: $item'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
                        child: Text(
                          'Interview Statistics',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isNarrow ? 48 : 84,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                            shadows: const [
                              Shadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 2)),
                            ],
                          ),
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
                                border: Border.all(color: const Color(0xFFEDEDED)),
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
                                  const Divider(height: 1),
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

            // PROMO BAR
            if (_showPromo)
              Container(
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

            // INTRO PARAGRAPH
            Padding(
              padding: EdgeInsets.fromLTRB(16, _showPromo ? 40 : 56, 16, 80),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: Text(
                    'Dive into our data to explore key findings and expanded statistics from our archive of 341 morning routines (56% female, 44% male). This page updates every week, so whether you\'re looking for the perfect time to wake up, or you just want to know if your breakfast choices land you in good company, check back often.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4A4A4A),
                      fontSize: isNarrow ? 17 : 20,
                      height: 1.7,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Screenshot_27-like section (no asset image; pure Flutter UI)
            const _StatsPreviewSection(),

            // Screenshot_30-like section (metrics + two charts)
            const _SecondaryMetricsSection(),
            const SizedBox(height: 28),
            const _TwoChartsSection(),
            const SizedBox(height: 40),
            const _TertiaryMetricsSection(),
            const SizedBox(height: 28),
            const _FoodChartsSection(),
            const SizedBox(height: 36),
            const _SocialLinksRow(),
            const SizedBox(height: 100),
            const _PageFooter(),
          ],
        ),
      ),
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
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const _HoverFadeText({
    required this.label,
    required this.fontSize,
    required this.fontWeight,
    required this.baseColor,
    this.normalOpacity = 0.85,
    this.hoverOpacity = 1.0,
    this.padding,
    this.onTap,
  });

  @override
  State<_HoverFadeText> createState() => _HoverFadeTextState();
}

class _MenuItem extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _MenuItem({
    required this.label,
    this.onTap,
    this.trailing,
  });

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
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeInOut,
                style: TextStyle(
                  color: _hover
                      ? const Color(0xFFE86F16)
                      : const Color(0xFF262626),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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

// === Stats preview section (replicates screenshot_27) ===
class _StatsPreviewSection extends StatelessWidget {
  const _StatsPreviewSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 800;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, isNarrow ? 48 : 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top metrics row inside a light orange outlined box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFF2D7C7), width: 2),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 16 : 32,
                  vertical: isNarrow ? 20 : 28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(child: _MetricTile(value: '07:29h', label: 'Sleep avg.')),
                    SizedBox(width: 12),
                    Expanded(child: _MetricTile(value: '06:24am', label: 'Wake-up avg.')),
                    SizedBox(width: 12),
                    Expanded(child: _MetricTile(value: '10:56pm', label: 'Bedtime avg.')),
                    SizedBox(width: 12),
                    Expanded(child: _MetricTile(value: '35%', label: 'Snooze their alarm')),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Chart area with grid + bars (lightweight style)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: SizedBox(
                  height: isNarrow ? 260 : 340,
                  child: const _Histogram(),
                ),
              ),

              // Caption block
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 16 : 24,
                  vertical: isNarrow ? 16 : 18,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8E8DA),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Text('Wake-up', style: TextStyle(color: Color(0xFFE86F16), fontWeight: FontWeight.w700, fontSize: 18)),
                        Text('/', style: TextStyle(color: Color(0xFF6A6A6A), fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('bedtime', style: TextStyle(color: Color(0xFF6A6A6A), fontWeight: FontWeight.w700, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'The average wake-up time of our participants is 06:24am, while the average bedtime is 10:56pm. The early birds we interviewed start their day as early as 03:00am, while some of the late risers sleep in until past 9:00. By 08:30, 97% of our participants are up.',
                      style: TextStyle(color: Color(0xFF6A6A6A), height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String value;
  final String label;
  const _MetricTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 800;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFFE86F16),
            fontWeight: FontWeight.w700,
            fontSize: isNarrow ? 20 : 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8A8A8A),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _Histogram extends StatelessWidget {
  const _Histogram();

  @override
  Widget build(BuildContext context) {
    // Hard-coded data approximating the screenshot: values are percentages
    const orange = Color(0xFFE86F16);
    const gray = Color(0xFF3C3C3C);
    final bars = <_Bar>[
      const _Bar(x: 0, pct: 19, color: gray),
      const _Bar(x: 1, pct: 3, color: gray),
      const _Bar(x: 2, pct: 1, color: gray),
      const _Bar(x: 3, pct: 1, color: gray),
      const _Bar(x: 4, pct: 4, color: orange),
      const _Bar(x: 5, pct: 21, color: orange),
      const _Bar(x: 6, pct: 30, color: orange),
      const _Bar(x: 7, pct: 25, color: orange),
      const _Bar(x: 8, pct: 10, color: orange),
      const _Bar(x: 9, pct: 1, color: gray),
      const _Bar(x: 10, pct: 31, color: gray),
      const _Bar(x: 11, pct: 29, color: gray),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: _HistogramPainter(bars: bars),
          size: Size(constraints.maxWidth, constraints.maxHeight),
        );
      },
    );
  }
}

class _Bar {
  final int x; // 0..11 representing Midnight..11
  final double pct; // 0..100
  final Color color;
  const _Bar({required this.x, required this.pct, required this.color});
}

class _HistogramPainter extends CustomPainter {
  final List<_Bar> bars;
  _HistogramPainter({required this.bars});

  static const _gridColor = Color(0xFFEDEDED); // lighter grid
  static const _axisText = Color(0xFF9A9A9A); // lighter labels

  @override
  void paint(Canvas canvas, Size size) {
    final leftPad = 40.0;
    final rightPad = 16.0;
    final bottomPad = 40.0;
    final topPad = 16.0;

    final chartRect = Rect.fromLTWH(leftPad, topPad, size.width - leftPad - rightPad, size.height - topPad - bottomPad);

    // Draw grid lines every 5% up to 35%
    final gridPaint = Paint()
      ..color = _gridColor
      ..strokeWidth = 1;
    const maxPct = 35.0; // as in screenshot axis
    for (double p = 0; p <= maxPct; p += 5) {
      final y = chartRect.bottom - (p / maxPct) * chartRect.height;
      // dashed grid line
      _dashLine(canvas, Offset(chartRect.left, y), Offset(chartRect.right, y), gridPaint, dash: 6, gap: 6);
      // y-axis labels
      final tp = _textPainter('${p.toStringAsFixed(0)}%', const TextStyle(color: _axisText, fontSize: 11));
      tp.layout();
      tp.paint(canvas, Offset(chartRect.left - 8 - tp.width, y - tp.height / 2));
    }

    // Draw bars. There are 12 buckets (Midnight..11)
    const bucketCount = 12;
    final gap = 12.0; // spacing between buckets
    final bucketWidth = (chartRect.width - gap * (bucketCount - 1)) / bucketCount;
    // Make bars thinner
    final barVisualWidth = (bucketWidth * 0.20);
    for (final bar in bars) {
      final xLeft = chartRect.left + bar.x * (bucketWidth + gap) + (bucketWidth - barVisualWidth) / 2;
      final barH = (bar.pct / maxPct) * chartRect.height;
      final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(xLeft, chartRect.bottom - barH, barVisualWidth, barH),
        const Radius.circular(1.5),
      );
      final paint = Paint()..color = bar.color;
      canvas.drawRRect(r, paint);
    }

    // X-axis labels
    final labels = ['Midnight', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];
    for (int i = 0; i < bucketCount; i++) {
      final xLeft = chartRect.left + i * (bucketWidth + gap);
      final center = xLeft + bucketWidth / 2;
      final tp = _textPainter(labels[i], const TextStyle(color: _axisText, fontSize: 11));
      tp.layout();
      tp.paint(canvas, Offset(center - tp.width / 2, chartRect.bottom + 8));
    }
  }

  static TextPainter _textPainter(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
  }

  // Utility to draw dashed lines
  void _dashLine(Canvas canvas, Offset start, Offset end, Paint paint, {double dash = 5, double gap = 5}) {
    // Fast path for horizontal lines (our grid): no trig needed
    if ((start.dy - end.dy).abs() < 0.5) {
      final y = start.dy;
      double x = start.dx;
      while (x < end.dx) {
        final x2 = (x + dash) > end.dx ? end.dx : (x + dash);
        canvas.drawLine(Offset(x, y), Offset(x2, y), paint);
        x = x2 + gap;
      }
      return;
    }

    // Generic fallback for angled lines using vector math without importing dart:math
    final delta = end - start;
    final length = delta.distance; // magnitude of the vector
    if (length == 0) return;
    final dir = delta / length; // unit direction vector
    double traveled = 0;
    while (traveled < length) {
      final drawLen = (traveled + dash <= length) ? dash : (length - traveled);
      final from = start + dir * traveled;
      final to = start + dir * (traveled + drawLen);
      canvas.drawLine(from, to, paint);
      traveled += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _HistogramPainter oldDelegate) => oldDelegate.bars != bars;
}

class _HoverFadeTextState extends State<_HoverFadeText> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final text = AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      style: TextStyle(
        color: widget.baseColor.withValues(
          alpha: _hover ? widget.hoverOpacity : widget.normalOpacity,
        ),
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
      child: Text(widget.label),
    );

    final content = widget.padding != null
        ? Padding(padding: widget.padding!, child: text)
        : text;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(onTap: widget.onTap, child: content),
    );
  }
}

// === Secondary metrics row (four percentages) ===
class _SecondaryMetricsSection extends StatelessWidget {
  const _SecondaryMetricsSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 900;
    final tiles = const [
      _SimpleMetricTile(value: '73%', label: 'Use an alarm'),
      _SimpleMetricTile(value: '62%', label: 'Meditate or practice yoga'),
      _SimpleMetricTile(value: '79%', label: 'Exercise'),
      _SimpleMetricTile(value: '68%', label: 'Sleep in on weekends'),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFF2D7C7), width: 2),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isNarrow ? 16 : 32,
              vertical: isNarrow ? 20 : 26,
            ),
            child: isNarrow
                ? Column(
                    children: [
                      tiles[0],
                      const SizedBox(height: 12),
                      tiles[1],
                      const SizedBox(height: 12),
                      tiles[2],
                      const SizedBox(height: 12),
                      tiles[3],
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(child: _SimpleMetricTile(value: '73%', label: 'Use an alarm')),
                      SizedBox(width: 12),
                      Expanded(child: _SimpleMetricTile(value: '62%', label: 'Meditate or practice yoga')),
                      SizedBox(width: 12),
                      Expanded(child: _SimpleMetricTile(value: '79%', label: 'Exercise')),
                      SizedBox(width: 12),
                      Expanded(child: _SimpleMetricTile(value: '68%', label: 'Sleep in on weekends')),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SimpleMetricTile extends StatelessWidget {
  final String value;
  final String label;
  const _SimpleMetricTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFFE86F16),
            fontWeight: FontWeight.w700,
            fontSize: isNarrow ? 22 : 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF8A8A8A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// === Two charts (horizontal bars + line) with captions ===
class _TwoChartsSection extends StatelessWidget {
  const _TwoChartsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1000;
              final children = [
                Expanded(child: _HorizontalBarChartCard()),
                SizedBox(width: wide ? 24 : 0, height: wide ? 0 : 24),
                Expanded(child: _LineChartCard()),
              ];
              return wide
                  ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: children)
                  : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
            },
          ),
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final Widget chart;
  final String title;
  final String body;
  const _ChartCard({required this.chart, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: const Color(0xFFEDEDED)),
          ),
          padding: const EdgeInsets.all(12),
          child: SizedBox(height: 260, child: chart),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8E8DA),
            borderRadius: BorderRadius.circular(2),
          ),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF2A2A2A))),
              const SizedBox(height: 8),
              Text(body, style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF6A6A6A))),
            ],
          ),
        )
      ],
    );
  }
}

class _HorizontalBarChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ChartCard(
      chart: const _HBarChart(),
      title: 'Time asleep',
      body:
          '38% of our participants sleep 8 hours a night, followed by 33% who sleep 7 hours, and 16% who sleep just 6.',
    );
  }
}

class _LineChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ChartCard(
      chart: const _LineChart(),
      title: 'Routine longevity',
      body:
          '65% of our participants have followed their morning routine for over a year, whereas 6% have been at it for less than 3 months.',
    );
  }
}

class _HBarChart extends StatelessWidget {
  const _HBarChart();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HBarChartPainter(),
      size: Size.infinite,
    );
  }
}

class _HBarChartPainter extends CustomPainter {
  static const orange = Color(0xFFE86F16);
  static const gridColor = Color(0xFFEDEDED);
  static const axisText = Color(0xFF9A9A9A);

  final List<MapEntry<String, double>> rows = const [
    MapEntry('+10h', 3),
    MapEntry('9h', 12),
    MapEntry('8h', 38),
    MapEntry('7h', 33),
    MapEntry('6h', 16),
    MapEntry('5h', 3),
    MapEntry('4h', 1),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final leftPad = 46.0; // for y-labels
    final rightPad = 12.0;
    final topPad = 8.0;
    final bottomPad = 34.0; // for x-axis labels
    final rect = Rect.fromLTWH(leftPad, topPad, size.width - leftPad - rightPad, size.height - topPad - bottomPad);

    // vertical grid 0..40% every 5
    final gridPaint = Paint()..color = gridColor..strokeWidth = 1;
    for (double p = 0; p <= 40; p += 5) {
      final x = rect.left + (p / 40) * rect.width;
      _dashLine(canvas, Offset(x, rect.top), Offset(x, rect.bottom), gridPaint, dash: 4, gap: 6);
      final tp = _textPainter('${p.toStringAsFixed(0)}%', const TextStyle(color: axisText, fontSize: 11));
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, rect.bottom + 6));
    }

    // y labels and bars
    final rowH = rect.height / rows.length;
    for (int i = 0; i < rows.length; i++) {
      final label = rows[i].key;
      final value = rows[i].value; // percent
      final yCenter = rect.top + rowH * (i + 0.5);
      final barH = rowH * 0.42;
      final barLen = (value / 40) * rect.width;

      // label
      final lp = _textPainter(label, const TextStyle(color: axisText, fontSize: 12));
      lp.layout();
      lp.paint(canvas, Offset(leftPad - 8 - lp.width, yCenter - lp.height / 2));

      // bar
      final r = RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(rect.left + barLen / 2, yCenter), width: barLen, height: barH),
          const Radius.circular(3));
      canvas.drawRRect(r, Paint()..color = orange);
    }
  }

  @override
  bool shouldRepaint(covariant _HBarChartPainter oldDelegate) => false;

  static TextPainter _textPainter(String text, TextStyle style) => TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      );

  void _dashLine(Canvas canvas, Offset start, Offset end, Paint paint, {double dash = 5, double gap = 5}) {
    // Fast path for vertical lines
    if ((start.dx - end.dx).abs() < 0.5) {
      final x = start.dx;
      double y = start.dy;
      while (y < end.dy) {
        final y2 = (y + dash) > end.dy ? end.dy : (y + dash);
        canvas.drawLine(Offset(x, y), Offset(x, y2), paint);
        y = y2 + gap;
      }
      return;
    }
    // Generic fallback (rare for this chart)
    final delta = end - start;
    final length = delta.distance;
    if (length == 0) return;
    final dir = delta / length;
    double traveled = 0;
    while (traveled < length) {
      final drawLen = (traveled + dash <= length) ? dash : (length - traveled);
      final from = start + dir * traveled;
      final to = start + dir * (traveled + drawLen);
      canvas.drawLine(from, to, paint);
      traveled += dash + gap;
    }
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(),
      size: Size.infinite,
    );
  }
}

class _LineChartPainter extends CustomPainter {
  static const orange = Color(0xFFE86F16);
  static const gridColor = Color(0xFFEDEDED);
  static const axisText = Color(0xFF9A9A9A);

  final List<String> labels = const ['1M', '2M', '3M', '4M', '5M', '6M', '9M', '1Y', '2Y', '3+'];
  final List<double> values = const [2, 5, 2, 1, 2, 12, 2, 8, 18, 35]; // approx to match screenshot

  @override
  void paint(Canvas canvas, Size size) {
    final leftPad = 40.0;
    final rightPad = 12.0;
    final topPad = 10.0;
    final bottomPad = 36.0;
    final rect = Rect.fromLTWH(leftPad, topPad, size.width - leftPad - rightPad, size.height - topPad - bottomPad);

    // horizontal dashed grid 0..40 step 5
    final gridPaint = Paint()..color = gridColor..strokeWidth = 1;
    for (double p = 0; p <= 40; p += 5) {
      final y = rect.bottom - (p / 40) * rect.height;
      _dashLine(canvas, Offset(rect.left, y), Offset(rect.right, y), gridPaint, dash: 6, gap: 6);
      final tp = _textPainter('${p.toStringAsFixed(0)}%', const TextStyle(color: axisText, fontSize: 11));
      tp.layout();
      tp.paint(canvas, Offset(rect.left - 8 - tp.width, y - tp.height / 2));
    }

    // x labels
    final step = rect.width / (labels.length - 1);
    for (int i = 0; i < labels.length; i++) {
      final x = rect.left + i * step;
      final tp = _textPainter(labels[i], const TextStyle(color: axisText, fontSize: 11));
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, rect.bottom + 8));
    }

    // line path
    final path = Path();
    for (int i = 0; i < values.length; i++) {
      final x = rect.left + i * step;
      final y = rect.bottom - (values[i] / 40) * rect.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final paintLine = Paint()
      ..color = orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) => false;

  static TextPainter _textPainter(String text, TextStyle style) => TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      );

  void _dashLine(Canvas canvas, Offset start, Offset end, Paint paint, {double dash = 5, double gap = 5}) {
    // Fast path for horizontal lines
    if ((start.dy - end.dy).abs() < 0.5) {
      final y = start.dy;
      double x = start.dx;
      while (x < end.dx) {
        final x2 = (x + dash) > end.dx ? end.dx : (x + dash);
        canvas.drawLine(Offset(x, y), Offset(x2, y), paint);
        x = x2 + gap;
      }
      return;
    }
    // generic fallback
    final delta = end - start;
    final length = delta.distance;
    if (length == 0) return;
    final dir = delta / length;
    double traveled = 0;
    while (traveled < length) {
      final drawLen = (traveled + dash <= length) ? dash : (length - traveled);
      final from = start + dir * traveled;
      final to = start + dir * (traveled + drawLen);
      canvas.drawLine(from, to, paint);
      traveled += dash + gap;
    }
  }
}

class _SocialLinksRow extends StatelessWidget {
  const _SocialLinksRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: Center(
        child: Wrap(
          spacing: 34,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            _HoverFadeIcon(icon: FontAwesomeIcons.xTwitter, size: 20),
            _HoverFadeIcon(icon: FontAwesomeIcons.squareFacebook, size: 20),
            _HoverFadeIcon(icon: Icons.more_horiz, size: 20),
          ],
        ),
      ),
    );
  }
}

class _HoverFadeIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  const _HoverFadeIcon({required this.icon, this.size = 18});

  @override
  State<_HoverFadeIcon> createState() => _HoverFadeIconState();
}

class _HoverFadeIconState extends State<_HoverFadeIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = Colors.black.withValues(alpha: _hover ? 0.75 : 0.35);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Icon(widget.icon, color: color, size: widget.size),
    );
  }
}

// === Tertiary metrics (four items) ===
class _TertiaryMetricsSection extends StatelessWidget {
  const _TertiaryMetricsSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 900;
    final tiles = const [
      _SimpleMetricTile(value: '50%', label: 'Check email immediately'),
      _SimpleMetricTile(value: '63%', label: 'Check phone immediately'),
      _SimpleMetricTile(value: '56%', label: 'Can follow routine anywhere'),
      _SimpleMetricTile(value: '37%', label: 'Same routine on weekends'),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFF2D7C7), width: 2),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isNarrow ? 16 : 32,
              vertical: isNarrow ? 20 : 26,
            ),
            child: isNarrow
                ? Column(
                    children: [
                      tiles[0],
                      const SizedBox(height: 12),
                      tiles[1],
                      const SizedBox(height: 12),
                      tiles[2],
                      const SizedBox(height: 12),
                      tiles[3],
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(child: _SimpleMetricTile(value: '50%', label: 'Check email immediately')),
                      SizedBox(width: 12),
                      Expanded(child: _SimpleMetricTile(value: '63%', label: 'Check phone immediately')),
                      SizedBox(width: 12),
                      Expanded(child: _SimpleMetricTile(value: '56%', label: 'Can follow routine anywhere')),
                      SizedBox(width: 12),
                      Expanded(child: _SimpleMetricTile(value: '37%', label: 'Same routine on weekends')),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// === Food charts (two vertical bar charts) ===
class _FoodChartsSection extends StatelessWidget {
  const _FoodChartsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 1000;
              final children = [
                Expanded(
                  child: _ChartCard(
                    chart: const _CategoryBarChart(
                      labels: ['Water', 'Coffee', 'Tea', 'Protein', 'Milk', 'Juice', 'Varies'],
                      values: [59, 27, 7, 1, 2, 3, 2],
                      maxPct: 60,
                    ),
                    title: 'First drink',
                    body:
                        '59% of our participants drink water first thing in the morning, but coffee (28%) and tea (8%) are also popular choices.',
                  ),
                ),
                SizedBox(width: wide ? 24 : 0, height: wide ? 0 : 24),
                Expanded(
                  child: _ChartCard(
                    chart: const _CategoryBarChart(
                      labels: ['Cereal', 'Oatmeal', 'Eggs', 'Smoothie', 'Fruit', 'Veggies', 'Bread', 'Yogurt', 'Nuts'],
                      values: [13, 35, 41, 22, 55, 19, 32, 21, 23],
                      maxPct: 60,
                    ),
                    title: 'Favorite breakfast foods',
                    body:
                        'Over half (57%) of the people we interviewed have fruit for breakfast, but eggs, oatmeal, and bread are also firm favorites.',
                  ),
                ),
              ];
              return wide
                  ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: children)
                  : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryBarChart extends StatelessWidget {
  final List<String> labels;
  final List<double> values; // percent values
  final double maxPct;
  const _CategoryBarChart({required this.labels, required this.values, this.maxPct = 60});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CategoryBarChartPainter(labels: labels, values: values, maxPct: maxPct),
      size: Size.infinite,
    );
  }
}

class _CategoryBarChartPainter extends CustomPainter {
  final List<String> labels;
  final List<double> values;
  final double maxPct;
  _CategoryBarChartPainter({required this.labels, required this.values, required this.maxPct});

  static const orange = Color(0xFFE86F16);
  static const gridColor = Color(0xFFEDEDED);
  static const axisText = Color(0xFF9A9A9A);

  @override
  void paint(Canvas canvas, Size size) {
    final leftPad = 40.0;
    final rightPad = 12.0;
    final topPad = 10.0;
    final bottomPad = 36.0;
    final rect = Rect.fromLTWH(leftPad, topPad, size.width - leftPad - rightPad, size.height - topPad - bottomPad);

    // dashed horizontal grid
    final gridPaint = Paint()..color = gridColor..strokeWidth = 1;
    for (double p = 0; p <= maxPct; p += 10) {
      final y = rect.bottom - (p / maxPct) * rect.height;
      _dashLine(canvas, Offset(rect.left, y), Offset(rect.right, y), gridPaint, dash: 6, gap: 6);
      final tp = _textPainter('${p.toStringAsFixed(0)}%', const TextStyle(color: axisText, fontSize: 11));
      tp.layout();
      tp.paint(canvas, Offset(rect.left - 8 - tp.width, y - tp.height / 2));
    }

    final count = labels.length;
    final gap = 18.0;
    final bucket = (rect.width - (count - 1) * gap) / count;
    final barW = bucket * 0.28; // thin bars
    for (int i = 0; i < count; i++) {
      final xLeft = rect.left + i * (bucket + gap) + (bucket - barW) / 2;
      final h = (values[i] / maxPct) * rect.height;
      final r = RRect.fromRectAndRadius(Rect.fromLTWH(xLeft, rect.bottom - h, barW, h), const Radius.circular(2));
      canvas.drawRRect(r, Paint()..color = orange);

      final tp = _textPainter(labels[i], const TextStyle(color: axisText, fontSize: 12));
      tp.layout();
      tp.paint(canvas, Offset(xLeft + barW / 2 - tp.width / 2, rect.bottom + 8));
    }
  }

  @override
  bool shouldRepaint(covariant _CategoryBarChartPainter oldDelegate) => false;

  static TextPainter _textPainter(String text, TextStyle style) => TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      );

  void _dashLine(Canvas canvas, Offset start, Offset end, Paint paint, {double dash = 5, double gap = 5}) {
    // horizontal lines
    if ((start.dy - end.dy).abs() < 0.5) {
      final y = start.dy;
      double x = start.dx;
      while (x < end.dx) {
        final x2 = (x + dash) > end.dx ? end.dx : (x + dash);
        canvas.drawLine(Offset(x, y), Offset(x2, y), paint);
        x = x2 + gap;
      }
      return;
    }
    // fallback
    final delta = end - start;
    final length = delta.distance;
    if (length == 0) return;
    final dir = delta / length;
    double traveled = 0;
    while (traveled < length) {
      final drawLen = (traveled + dash <= length) ? dash : (length - traveled);
      final from = start + dir * traveled;
      final to = start + dir * (traveled + drawLen);
      canvas.drawLine(from, to, paint);
      traveled += dash + gap;
    }
  }
}

class _PageFooter extends StatelessWidget {
  const _PageFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // Social links
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 8,
                children: const [
                  _FooterFadeText('Twitter'),
                  _FooterFadeText('Facebook'),
                  _FooterFadeText('Instagram'),
                  _FooterFadeText('Mastodon'),
                ],
              ),
              const SizedBox(height: 14),
              // Legal line
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: const [
                  _FooterText('© 2012-2024 Michael Xander and Benjamin Spall ·'),
                  _FooterFadeText('Legal'),
                  _FooterText('·'),
                  _FooterFadeText('Privacy'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterFadeText extends StatefulWidget {
  final String label;
  const _FooterFadeText(this.label);

  @override
  State<_FooterFadeText> createState() => _FooterFadeTextState();
}

class _FooterFadeTextState extends State<_FooterFadeText> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final color = const Color(0xFF4A4A4A).withValues(alpha: _hover ? 0.85 : 0.55);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Text(widget.label, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}

class _FooterText extends StatelessWidget {
  final String label;
  const _FooterText(this.label);
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: Color(0xFF9A9A9A), fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
