import 'package:flutter/material.dart';
import '../pages/interview_statistics.dart';
// Removed old Q&A page import (file renamed). Use questions_answers.dart if needed.
import '../pages/questions_answers.dart';
import '../pages/morning_product.dart';

class ExploreMoreSection extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Color color;

  const ExploreMoreSection({
    super.key,
    this.title = 'Explore More',
    this.fontSize = 96,
    this.fontWeight = FontWeight.w700,
    this.padding = const EdgeInsets.symmetric(vertical: 64),
    this.color = const Color(0xFF262626),
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

class ExploreMoreIntro extends StatelessWidget {
  final EdgeInsets padding;
  final double fontSize;
  final Color textColor;

  const ExploreMoreIntro({
    super.key,
    this.padding = const EdgeInsets.only(top: 8, bottom: 32),
    this.fontSize = 22,
    this.textColor = const Color(0xFF262626),
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
              child: const Text(
                "Want to dig deeper? We’ve collected together data from our online archive of 341 morning routines.",
                style: TextStyle(
                  fontSize: 21,
                  color: Color(0xFF262626),
                  height: 1,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Three image-backed cards with dark overlay and hover effect
class ExploreMoreCards extends StatelessWidget {
  final EdgeInsets padding;
  final double cardHeight;
  final double gap;
  final List<ExploreCardItem> items;

  const ExploreMoreCards({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.cardHeight = 240,
    this.gap = 4,
    this.items = const [
      ExploreCardItem(
        title: 'Interview Statistics',
        subtitle:
            'Dive into our data to explore our key findings from 341 morning routines.',
        imagePath: 'assets/9.png',
      ),
      ExploreCardItem(
        title: 'Questions & Answers',
        subtitle:
            'The easiest way to discover new ideas to mix into your morning routine.',
        imagePath: 'assets/10.png',
      ),
      ExploreCardItem(
        title: 'Morning Products',
        subtitle:
            'The best products to help create your perfect morning routine.',
        imagePath: 'assets/11.png',
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final maxWidth = screenWidth < 1280 ? screenWidth - 32 : 1200.0;
          final crossAxisCount = screenWidth >= 1100
              ? 3
              : screenWidth >= 750
                  ? 2
                  : 1;
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: cardHeight,
                  mainAxisSpacing: gap,
                  crossAxisSpacing: gap,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _HoverImageCard(item: items[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExploreCardItem {
  final String title;
  final String subtitle;
  final String imagePath;

  const ExploreCardItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class _HoverImageCard extends StatefulWidget {
  final ExploreCardItem item;
  const _HoverImageCard({required this.item});

  @override
  State<_HoverImageCard> createState() => _HoverImageCardState();
}

class _HoverImageCardState extends State<_HoverImageCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(4);
  final bool isInterviewStats = widget.item.title == 'Interview Statistics';
  final bool isQA = widget.item.title == 'Questions & Answers';
  final bool isMorningProducts = widget.item.title == 'Morning Products';
    return MouseRegion(
    cursor: (isInterviewStats || isQA || isMorningProducts)
      ? SystemMouseCursors.click
      : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {
          if (isInterviewStats) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const InterviewStatisticsPage(),
              ),
            );
          } else if (isQA) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const QuestionsAnswersPage(),
              ),
            );
          } else if (isMorningProducts) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const MorningProductsPage(),
              ),
            );
          }
        },
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            if (_hover)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            opacity: _hover ? 1.0 : 0.94,
            child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                widget.item.imagePath,
                fit: BoxFit.cover,
              ),
              // Gradient overlay (darker by default, lightens on hover)
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: _hover ? 0.30 : 0.45),
                      Colors.black.withValues(alpha: _hover ? 0.35 : 0.60),
                    ],
                  ),
                ),
              ),
              // Centered text block
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.item.subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 15,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
  }
}
