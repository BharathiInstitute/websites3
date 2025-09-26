import 'package:flutter/material.dart';

/// A single row of retailer logos, matching the main page layout.
class RetailerLogosBar extends StatelessWidget {
  const RetailerLogosBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double upwardShift = -150; // pixels to move logos further up
    const double logoSpacing = 150; // increased horizontal spacing between logos
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60), // increase vertical spacing above/below row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: logoSpacing / 4),
            child: Transform.translate(
              offset: Offset(0, upwardShift),
              child: Image.asset('assets/3.png', width: 180, fit: BoxFit.contain), // Amazon
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: logoSpacing / 4),
            child: Transform.translate(
              offset: Offset(0, upwardShift),
              child: Image.asset('assets/4.png', width: 180, fit: BoxFit.contain), // Barnes & Noble
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: logoSpacing / 4),
            child: Transform.translate(
              offset: Offset(0, upwardShift),
              child: Image.asset('assets/7.png', width: 150, fit: BoxFit.contain), // Powell's
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: logoSpacing / 4),
            child: Transform.translate(
              offset: Offset(0, upwardShift),
              child: Image.asset('assets/5.png', width: 180, fit: BoxFit.contain), // IndieBound
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: logoSpacing / 4),
            child: Transform.translate(
              offset: Offset(0, upwardShift),
              child: Image.asset('assets/6.png', width: 150, fit: BoxFit.contain), // Audible
            ),
          ),
        ],
      ),
    );
  }
}
