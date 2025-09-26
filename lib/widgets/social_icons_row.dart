import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background like screenshot
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.twitter,
              color: Colors.grey, // Grey color like in screenshot
              size: 28,
            ),
            const SizedBox(width: 20),
            Icon(
              FontAwesomeIcons.facebook,
              color: Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 20),
            const Icon(
              Icons.more_horiz,
              color: Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
