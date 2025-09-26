import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A row of social media action icons (X, Facebook, and More …)
/// with a subtle fade hover effect to match the screenshot style.
class SocialMediaRow extends StatelessWidget {
	final double iconSize;
	final Color baseColor;
	final double baseOpacity; // default (idle) opacity
	final double hoverOpacity; // opacity on hover
	final Duration duration;
	final EdgeInsets padding;
	final MainAxisAlignment alignment;
	final void Function(String key)? onTap;

	const SocialMediaRow({
		super.key,
		this.iconSize = 20,
		this.baseColor = const Color(0xFFC9C9C9), // grey similar to screenshot
		this.baseOpacity = 0.7,
		this.hoverOpacity = 1.0,
		this.duration = const Duration(milliseconds: 180),
		this.padding = const EdgeInsets.only(top: 16.0),
		this.alignment = MainAxisAlignment.center,
		this.onTap,
	});

	@override
	Widget build(BuildContext context) {
		final icons = <({IconData data, String key})>[
			(data: FontAwesomeIcons.xTwitter, key: 'twitter'),
			(data: FontAwesomeIcons.squareFacebook, key: 'facebook'),
			(data: Icons.more_horiz, key: 'more'),
		];

		return Padding(
			padding: padding,
			child: Row(
				mainAxisAlignment: alignment,
				children: [
					for (final item in icons) ...[
						_FadeIconButton(
							icon: item.data,
							keyName: item.key,
							size: iconSize,
							color: baseColor,
							baseOpacity: baseOpacity,
							hoverOpacity: hoverOpacity,
							duration: duration,
							onTap: onTap,
						),
						if (item != icons.last) const SizedBox(width: 34),
					]
				],
			),
		);
	}
}

class _FadeIconButton extends StatefulWidget {
	final IconData icon;
	final String keyName;
	final double size;
	final Color color;
	final double baseOpacity;
	final double hoverOpacity;
	final Duration duration;
	final void Function(String key)? onTap;

	const _FadeIconButton({
		required this.icon,
		required this.keyName,
		required this.size,
		required this.color,
		required this.baseOpacity,
		required this.hoverOpacity,
		required this.duration,
		this.onTap,
	});

	@override
	State<_FadeIconButton> createState() => _FadeIconButtonState();
}

class _FadeIconButtonState extends State<_FadeIconButton> {
	bool _hovering = false;

	@override
	Widget build(BuildContext context) {
		final opacity = _hovering ? widget.hoverOpacity : widget.baseOpacity;

		return MouseRegion(
			cursor: SystemMouseCursors.click,
			onEnter: (_) => setState(() => _hovering = true),
			onExit: (_) => setState(() => _hovering = false),
			child: GestureDetector(
				onTap: widget.onTap != null ? () => widget.onTap!(widget.keyName) : null,
				behavior: HitTestBehavior.opaque,
				child: AnimatedOpacity(
					opacity: opacity,
					duration: widget.duration,
					curve: Curves.easeInOut,
					child: Icon(
						widget.icon,
						size: widget.size,
						color: widget.color,
					),
				),
			),
		);
	}
}

