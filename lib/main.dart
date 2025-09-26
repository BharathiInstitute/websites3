import 'package:flutter/material.dart';
import 'widgets/hero_section.dart';
import 'content/morning_hero_content.dart';
import 'sections/book_promo_section.dart';
import 'content/buy_book.dart';
import 'logos/retailer_logos.dart';
import 'content/about_the_book.dart';
import 'sections/bloom_berg.dart';
import 'sections/peek_inside.dart';
import 'sections/online_archive.dart';
import 'widgets/favorites_grid.dart';
import 'sections/explore_more.dart';
import 'sections/footer.dart';
// Import only the page widget to avoid name clash with FooterSection in sections/footer.dart
import 'pages/questions_answers.dart' show QuestionsAnswersPage;
import 'pages/interview_statistics.dart';
import 'pages/morning_product.dart';
import 'pages/book_page.dart' show BookPage;
import 'pages/routines_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text('About Page (placeholder)')),
      );
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/qa': (_) => const QuestionsAnswersPage(), // added reference to Questions & Answers page
        '/stats': (_) => const InterviewStatisticsPage(), // added Interview Statistics page route
        '/products': (_) => const MorningProductsPage(), // added Morning Products page route
        '/routines': (_) => const RoutinesPage(),
        '/book': (_) => const BookPage(),
        '/about': (_) => const AboutPage(),
      },
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
                  onNavTap: (label) {
                    final l = label.toLowerCase();
                    if (l == 'routines') {
                      Navigator.of(context).pushNamed('/routines');
                    } else if (l == 'book') {
                      Navigator.of(context).pushNamed('/book');
                    } else if (l == 'stats') {
                      Navigator.of(context).pushNamed('/stats');
                    } else if (l == 'about') {
                      Navigator.of(context).pushNamed('/about');
                    }
                  },
                  onMoreSelected: (item) {
                    final i = item.toLowerCase();
                    if (i == 'q&a') {
                      Navigator.of(context).pushNamed('/qa');
                    } else if (i == 'products') {
                      Navigator.of(context).pushNamed('/products');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Clicked: $item')),
                      );
                    }
                  },
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
              // Extra space after About + social icons
              const SizedBox(height: 150),
              // Bloomberg review quote below the About section
              const BloombergReviewQuote(),
              // Extra vertical space between sections
              const SizedBox(height: 150),
              // Peek Inside section with hoverable links
              const PeekInsideSection(),
              // Extra space between Peek Inside and Online Archive
              const SizedBox(height: 100),
              // Online Archive heading centered below Peek Inside
              OnlineArchiveSection(padding: EdgeInsets.only(top: 60, bottom: 8)),
              OnlineArchiveIntro(padding: EdgeInsets.only(top: 0, bottom: 32)),
              // Favorites grid with hover effect (orange accent)
              const FavoritesGrid(),
              // Space before the Explore More intro (smaller than before to match screenshot_17)
              const SizedBox(height: 130),
              // Place the Explore More heading above the one-line text
              const ExploreMoreSection(padding: EdgeInsets.only(top: 0, bottom: 12)),
              const ExploreMoreIntro(padding: EdgeInsets.only(top: 0, bottom: 20)),
              // Extra space before the three image cards
              const SizedBox(height: 24),
              const ExploreMoreCards(
                // Decreased height per request
                cardHeight: 200,
                gap: 4,
              ),
              const SizedBox(height: 300),
              const FooterSection(padding: EdgeInsets.only(top: 40, bottom: 120)),
            ],
          ),
        ),
      ),
    );
  }
}
