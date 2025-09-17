import 'package:flutter/material.dart';

/// Centered subtitle text used in the hero section.
class SubTitle extends StatelessWidget {
	const SubTitle({
		super.key,
		required this.text,
		this.textStyle = const TextStyle(
			fontSize: 60,
			color: Colors.white,
			fontWeight: FontWeight.w400,
		),
		this.lineHeight = 1.0,
		this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
		this.alignment = Alignment.center,
		this.textAlign = TextAlign.center,
	});

	final String text;
	final TextStyle textStyle;
	/// Line height multiplier to control spacing between wrapped lines.
	final double lineHeight;
	final EdgeInsets padding;
	final Alignment alignment;
	final TextAlign textAlign;

	@override
	Widget build(BuildContext context) {
		final effectiveStyle = textStyle.copyWith(height: lineHeight);
		return Align(
			alignment: alignment,
			child: Padding(
				padding: padding,
				child: Text(
					text,
					style: effectiveStyle,
					textAlign: textAlign,
				),
			),
		);
	}
}

