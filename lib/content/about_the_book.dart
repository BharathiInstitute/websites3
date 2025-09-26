import 'package:flutter/material.dart';
import 'package:websites3/logos/social_media.dart';

/// A configurable title widget for "About the Book" with position and font size controls.
class AboutTheBookTitle extends StatelessWidget {
  final double fontSize;
  final double offsetY;
  final double offsetX;
  final FontWeight fontWeight;
  final Color color;
  final EdgeInsets padding;
  final bool showSocialIcons;

  const AboutTheBookTitle({
    super.key,
    this.fontSize =65,
    this.offsetY = 0,
    this.offsetX = 0,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    this.showSocialIcons = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Transform.translate(
        offset: Offset(offsetX, offsetY),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'About the Book',
              style: TextStyle(
                fontSize: fontSize + 20,
                fontWeight: fontWeight,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 700),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Chosen as one of Amazon’s best business books of 2018, one of the Financial Times books of the month upon release, and one of Business Insider’s best business books to read this summer.',
                      style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Marie Kondo performs a quick tidying ritual to quiet her mind before leaving the house. The president of Pixar and Walt Disney Animation Studios, Ed Catmull, mixes three shots of espresso with three scoops of cocoa powder and two sweeteners. Fitness expert Jillian Michaels doesn’t set an alarm, because her five-year-old jolts her from sleep by jumping into bed for a cuddle every morning.',
                      style: TextStyle(fontSize: 20, color: Colors.black87, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 24),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black87, height: 1.5),
                        children: [
                          TextSpan(text: 'Part instruction manual, part someone else’s diary, the authors of '),
                          TextSpan(text: 'My Morning Routine', style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: ' interviewed sixty-four of today’s most successful people—including three-time Olympic gold medalist Rebecca Soni, Twitter cofounder Biz Stone, and General Stanley McChrystal—and offer timeless advice on creating a routine of your own.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Some routines are all about early morning exercise and spartan living; others are more leisurely and self-indulgent. What they have in common is they don’t feel like a chore. Once you land on the right routine, you’ll look forward to waking up.',
                      style: TextStyle(fontSize: 20, color: Colors.black87, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: Image.asset(
                        'assets/8.png',
                        width: 600,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 24),
                    // Responsive container with even spacing for the new description
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        // Choose a comfortable max width based on screen size
                        final maxWidth = screenWidth < 600
                            ? 520.0
                            : (screenWidth < 1000 ? 700.0 : 820.0);
                        return Center(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'This comprehensive guide will show you how to get into a routine that works for you so that you can develop the habits that move you forward. Much like a Jenga stack is only as sturdy as its foundational blocks, the choices we make throughout our day depend on the intentions we set in the morning. Like it or not, our morning habits form the stack that our whole day is built on.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Whether you want to boost your productivity, implement a workout or meditation routine, or just learn to roll with the punches in the morning, this book has you covered.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                if (showSocialIcons) ...const [
                                  SizedBox(height: 40),
                                  SocialMediaRow(
                                    iconSize: 22,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
