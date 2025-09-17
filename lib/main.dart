import 'package:flutter/material.dart';
import 'widgets/hero_section.dart';
import 'content/morning_hero_content.dart';
import 'sections/book_promo_section.dart';
import 'content/buy_book.dart';
import 'content/retailer_logos.dart';
import 'content/about_the_book.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Half-screen hero with composed Morning hero content
              HeroSection(
                viewportFraction: 0.5,
                // Show the small 20.png icon on the hero
                showOverlayImage: true,
                overlayImagePath: 'assets/20.png',
                overlayTop: 25,
                overlayLeft: 290,
                overlayWidth: 48,
                overlayHeight: 48,
                overlayBorderRadius: 24,
                child: MorningHeroContent(
                  title: 'My Morning Routine',
                  subtitle:                                  'A book and website to help you create                                                                                         a morning routine that works for you',
                  subtitleLineHeight: 1.0,
                ),
              ),
              // Book promo section resembling the screenshot
              BookPromoSection(
                // Paragraph tuning to resemble screenshot_30
                maxTextWidth: 870,
                textRightShift: 200, // bring text a bit closer to center-left
                textTopShift: -10,   // keep slight upward nudge
                paragraphFontSizeWide: 35,
                paragraphFontSizeNarrow: 45,
                // Bigger CTA buttons
                ctaWidth: 180,
                ctaHeight: 80,
                // Decrease the book image size
                bookImageWidth: 420,
                // Book image placement to resemble screenshot_34
                bookImageOffsetX: -180, // move a bit left from the right edge
                bookImageOffsetY: -159, // nudge slightly upward
              ),
              // Centered title below the promo section
              BuyBookTitle(
                topPadding: 96,
                bottomPadding: 48,
                fontSize: 80,
                fontWeight: FontWeight.w700,
              ),
              const BuyBookSubtext(
                topPadding: 0,
                bottomPadding: 72,
                fontSize: 24,
              ),
              // Retailer logos row moved to its own widget
              const RetailerLogosBar(),
              // About the Book title with position and font size controls (now below logos)
              const AboutTheBookTitle(
                fontSize: 54,
                offsetY: -20, // move up
                offsetX: 0,   // centered
                fontWeight: FontWeight.bold,
                color: Colors.black,
                padding: EdgeInsets.only(bottom: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
