import 'package:flutter/material.dart';

/// A small widget that shows a "More" label with a dropdown icon next to it.
/// Custom overlay menu resembles the provided design: rounded, shadowed card
/// with a small arrow pointer and list of options (e.g., Q&A, Quotes, Deals • ...).
class MoreDropdown extends StatefulWidget {
	const MoreDropdown({
		super.key,
		this.label = 'More',
		this.textStyle = const TextStyle(
			color: Colors.white,
			fontSize: 14,
			fontWeight: FontWeight.w600,
		),
		this.icon = Icons.arrow_drop_down_rounded,
		this.iconColor,
		this.iconSize = 18,
		this.spacing = 6.0,
		this.normalOpacity = 0.85,
		this.hoverOpacity = 1.0,
		this.hoverDuration = const Duration(milliseconds: 150),
		this.menuItemColor = const Color(0xFF555555),
		this.menuItemHoverColor = const Color(0xFFF9742C),
		this.options = const <String>[
			'Q&A',
			'Quotes',
			'Deals',
			'Products',
			'Library',
			'Articles',
			'Press',
		],
		this.highlightLabel = 'Deals',
		this.highlightDotColor = const Color(0xFFFF7A00),
		this.onSelected,
		this.menuWidth = 180,
		this.menuItemPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
		this.menuOffset = const Offset(0, 10),
		this.menuBorderRadius = 10,
	});

	/// Text label (defaults to "More").
	final String label;

	/// Style for the label text.
	final TextStyle textStyle;

	/// The dropdown icon to show next to the label.
	final IconData icon;

	/// Color of the icon; if null, uses [textStyle.color].
	final Color? iconColor;

	/// Size of the icon.
	final double iconSize;

	/// Spacing between the label and the icon.
	final double spacing;

	/// Opacity when not hovered.
	final double normalOpacity;

	/// Opacity when hovered.
	final double hoverOpacity;

	/// Duration of the hover fade animation.
	final Duration hoverDuration;

	/// Text color for menu items (at rest)
	final Color menuItemColor;

	/// Text color for menu items on hover
	final Color menuItemHoverColor;

	/// Menu options.
	final List<String> options;

	/// Label that should show a small dot (e.g., Deals).
	final String? highlightLabel;

	/// Dot color for the highlighted label.
	final Color highlightDotColor;

	/// Callback when an option is selected from the menu.
	final ValueChanged<String>? onSelected;

	/// Menu appearance controls
	final double menuWidth;
	final EdgeInsets menuItemPadding;
	final Offset menuOffset;
	final double menuBorderRadius;

	@override
	State<MoreDropdown> createState() => _MoreDropdownState();
}

class _MoreDropdownState extends State<MoreDropdown> {
	bool _hovering = false;
	final LayerLink _link = LayerLink();
	OverlayEntry? _entry;
	bool _isOpen = false;
	final GlobalKey _targetKey = GlobalKey();
	Offset _computedOffset = Offset.zero;

	@override
	void dispose() {
		_removeOverlay();
		super.dispose();
	}

	void _toggleOverlay() {
		if (_entry == null) {
			_showOverlay();
		} else {
			_removeOverlay();
		}
	}

	void _showOverlay() {
		final overlay = Overlay.of(context);

			// Compute horizontal offset so the menu stays within the screen (align right edge)
			final box = _targetKey.currentContext?.findRenderObject() as RenderBox?;
			final anchorWidth = box?.size.width ?? 0.0;
			final dx = -((widget.menuWidth - anchorWidth).clamp(0.0, widget.menuWidth));
			_computedOffset = Offset(dx, widget.menuOffset.dy);

		_entry = OverlayEntry(
			builder: (context) {
				return Stack(
					children: [
						// Dismiss area
						Positioned.fill(
							child: GestureDetector(onTap: _removeOverlay),
						),
						CompositedTransformFollower(
							link: _link,
										offset: _computedOffset,
							showWhenUnlinked: false,
							child: _DropdownCard(
								width: widget.menuWidth,
								borderRadius: widget.menuBorderRadius,
								items: widget.options,
								itemPadding: widget.menuItemPadding,
								highlightLabel: widget.highlightLabel,
								highlightDotColor: widget.highlightDotColor,
								hoverDuration: widget.hoverDuration,
								itemColor: widget.menuItemColor,
								itemHoverColor: widget.menuItemHoverColor,
								onSelect: (value) {
														widget.onSelected?.call(value);
														_removeOverlay();
								},
							),
						),
					],
				);
			},
		);

							setState(() => _isOpen = true);
							overlay.insert(_entry!);
	}

	void _removeOverlay() {
							if (_entry != null) {
								_entry!.remove();
								_entry = null;
								setState(() => _isOpen = false);
							}
	}

	@override
	Widget build(BuildContext context) {
		final labelAndIcon = MouseRegion(
			onEnter: (_) => setState(() => _hovering = true),
			onExit: (_) => setState(() => _hovering = false),
			child: AnimatedOpacity(
				duration: widget.hoverDuration,
				opacity: _hovering ? widget.hoverOpacity : widget.normalOpacity,
				child: Row(
					mainAxisSize: MainAxisSize.min,
					children: [
						Text(widget.label, style: widget.textStyle),
						SizedBox(width: widget.spacing),
									AnimatedOpacity(
										duration: widget.hoverDuration,
										opacity: _isOpen ? 0.0 : 1.0,
										child: Icon(
											widget.icon,
											size: widget.iconSize,
											color: widget.iconColor ?? widget.textStyle.color,
										),
									),
					],
				),
			),
		);

		return CompositedTransformTarget(
			link: _link,
			child: GestureDetector(
				behavior: HitTestBehavior.opaque,
				onTap: _toggleOverlay,
					child: KeyedSubtree(
						key: _targetKey,
						child: labelAndIcon,
					),
			),
		);
	}
}

class _DropdownCard extends StatefulWidget {
	const _DropdownCard({
		required this.width,
		required this.borderRadius,
		required this.items,
		required this.itemPadding,
		required this.onSelect,
		required this.highlightLabel,
		required this.highlightDotColor,
		required this.hoverDuration,
		required this.itemColor,
		required this.itemHoverColor,
	});

	final double width;
	final double borderRadius;
	final List<String> items;
	final EdgeInsets itemPadding;
	final ValueChanged<String> onSelect;
	final String? highlightLabel;
	final Color highlightDotColor;
	final Duration hoverDuration;
	final Color itemColor;
	final Color itemHoverColor;

	@override
	State<_DropdownCard> createState() => _DropdownCardState();
}

class _DropdownCardState extends State<_DropdownCard> {
	int? _hoverIndex;

	@override
	Widget build(BuildContext context) {
		final radius = BorderRadius.circular(widget.borderRadius);
		return Material(
			color: Colors.transparent,
			child: Column(
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.end,
				children: [
					CustomPaint(
						size: const Size(18, 10),
						painter: _TrianglePainter(color: Colors.white),
					),
					Container(
						width: widget.width,
						decoration: BoxDecoration(
							color: Colors.white,
							borderRadius: radius,
							boxShadow: const [
								BoxShadow(
									color: Color(0x33000000),
									blurRadius: 12,
									offset: Offset(0, 6),
								),
							],
						),
						child: Column(
							mainAxisSize: MainAxisSize.min,
							children: [
								for (int i = 0; i < widget.items.length; i++) ...[
									MouseRegion(
										onEnter: (_) => setState(() => _hoverIndex = i),
										onExit: (_) => setState(() => _hoverIndex = null),
										child: InkWell(
											onTap: () => widget.onSelect(widget.items[i]),
											child: Padding(
												padding: widget.itemPadding,
												child: Row(
													children: [
														Expanded(
															child: AnimatedDefaultTextStyle(
																duration: widget.hoverDuration,
																style: TextStyle(
																	color: _hoverIndex == i ? widget.itemHoverColor : widget.itemColor,
																	fontSize: 14,
																	fontWeight: FontWeight.w500,
																),
																child: Text(widget.items[i]),
															),
														),
														if (widget.highlightLabel != null && widget.items[i] == widget.highlightLabel)
															Container(
																width: 6,
																height: 6,
																decoration: BoxDecoration(
																	color: widget.highlightDotColor,
																	shape: BoxShape.circle,
																),
															),
													],
												),
											),
										),
									),
									if (i == widget.items.length - 2)
										const Divider(height: 1, thickness: 1, color: Color(0xFFEAEAEA)),
								],
							],
						),
					),
				],
			),
		);
	}
}

class _TrianglePainter extends CustomPainter {
	const _TrianglePainter({required this.color});
	final Color color;

	@override
	void paint(Canvas canvas, Size size) {
		final paint = Paint()..color = color;
		final path = Path()
			..moveTo(0, size.height)
			..lineTo(size.width / 2, 0)
			..lineTo(size.width, size.height)
			..close();
		canvas.drawPath(path, paint);
	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


