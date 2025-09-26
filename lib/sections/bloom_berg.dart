import 'package:flutter/material.dart';

/// A responsive container showing the Bloomberg review quote.
class BloombergReviewQuote extends StatelessWidget {
	final EdgeInsets padding;
	final double quoteFontSize;
	final double attributionFontSize;
	final FontWeight quoteWeight;
	final Color textColor;
	final Color attributionColor;
	final TextAlign textAlign;

	const BloombergReviewQuote({
		super.key,
		this.padding = const EdgeInsets.symmetric(vertical: 24.0),
		this.quoteFontSize = 16,
		this.attributionFontSize = 16,
		this.quoteWeight = FontWeight.w400,
		this.textColor = Colors.black87,
		this.attributionColor = const Color(0xFF757575),
		this.textAlign = TextAlign.center,
	});

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: padding,
			child: LayoutBuilder(
				builder: (context, constraints) {
					final screenWidth = MediaQuery.of(context).size.width;
					final maxWidth = screenWidth < 600
							? 520.0
							: (screenWidth < 1000 ? 700.0 : 820.0);
								return Center(
									child: Stack(
										alignment: Alignment.topCenter,
										clipBehavior: Clip.none,
										children: [
											// Card container
											Container(
												constraints: BoxConstraints(maxWidth: maxWidth),
												margin: const EdgeInsets.only(top: 28), // room for the badge overlap
												padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
												decoration: BoxDecoration(
													color: Colors.white,
													borderRadius: BorderRadius.circular(10),
													border: Border.all(color: const Color(0xFFE0E0E0)),
													boxShadow: const [
														BoxShadow(
															color: Color(0x0D000000), // very subtle shadow
															blurRadius: 6,
															offset: Offset(0, 2),
														),
													],
												),
												child: Column(
													mainAxisSize: MainAxisSize.min,
													crossAxisAlignment: CrossAxisAlignment.center,
													children: [
														RichText(
															textAlign: textAlign,
															text: TextSpan(
																children: [
																	TextSpan(
																		text:
																				'“I don’t know that the planking and the blended fruit has made me more productive, but who cares? They’ve made my mornings suck 23 percent less. That seems like success to me.” ',
																		style: TextStyle(
																			fontSize: quoteFontSize,
																			color: textColor,
																			height: 1.5,
																			fontStyle: FontStyle.italic,
																			fontWeight: quoteWeight,
																		),
																	),
																	TextSpan(
																		text: '— Bloomberg review',
																		style: TextStyle(
																			fontSize: attributionFontSize,
																			color: attributionColor,
																			fontWeight: FontWeight.w500,
																			letterSpacing: 0.2,
																			fontStyle: FontStyle.normal,
																		),
																	),
																],
															),
														),
													],
												),
											),
											// Overlapping circular badge
											Positioned(
												top: 0,
												child: Transform.translate(
													offset: const Offset(0, -28),
													child: Container(
														decoration: BoxDecoration(
															shape: BoxShape.circle,
															color: Color(0xFF3E18FF), // vivid blue-purple similar to screenshot
															border: Border.all(color: Colors.white, width: 3),
														),
														padding: const EdgeInsets.all(12),
														child: const Text(
															'Bloomberg',
															style: TextStyle(
																color: Colors.white,
																fontSize: 6,
																fontWeight: FontWeight.w600,
																letterSpacing: 0.2,
															),
														),
													),
												),
											),
										],
									),
								);
				},
			),
		);
	}
}

