import 'package:flutter/material.dart';

const _kOrange = Color(0xFFFF7A00);

class FavoritePerson {
  final String name;
  final String subtitle;
  final String? asset; // optional local asset path
  final String? imageUrl; // optional network image

  const FavoritePerson({
    required this.name,
    required this.subtitle,
    this.asset,
    this.imageUrl,
  });
}

class FavoritesGrid extends StatelessWidget {
  final List<FavoritePerson> people;
  final EdgeInsets padding;
  final double cardHeight;

  const FavoritesGrid({
    super.key,
    this.people = const [
      FavoritePerson(name: 'Robert Greene', subtitle: 'Author', imageUrl: 'https://i.pravatar.cc/120?img=11'),
      FavoritePerson(name: 'Arianna Huffington', subtitle: 'Co-Founder, Huffington Post', imageUrl: 'https://i.pravatar.cc/120?img=32'),
      FavoritePerson(name: 'Stew Smith', subtitle: 'Former Navy SEAL Lieutenant', imageUrl: 'https://i.pravatar.cc/120?img=5'),
      FavoritePerson(name: 'Julie Zhuo', subtitle: 'Product Design VP, Facebook', imageUrl: 'https://i.pravatar.cc/120?img=47'),
      FavoritePerson(name: 'Aubrey Marcus', subtitle: 'CEO of Onnit', imageUrl: 'https://i.pravatar.cc/120?img=14'),
      FavoritePerson(name: 'Kate Nafisi', subtitle: 'Designer, Finisher', imageUrl: 'https://i.pravatar.cc/120?img=56'),
      FavoritePerson(name: 'Bob Guest', subtitle: 'Entrepreneur, Bike Rider', imageUrl: 'https://i.pravatar.cc/120?img=24'),
      FavoritePerson(name: 'Susan Lin', subtitle: 'Lead Product Designer', imageUrl: 'https://i.pravatar.cc/120?img=65'),
      FavoritePerson(name: 'George Foreman III', subtitle: 'Retired Professional Boxer', imageUrl: 'https://i.pravatar.cc/120?img=19'),
      FavoritePerson(name: 'Liz Fosslien', subtitle: 'Illustrator', imageUrl: 'https://i.pravatar.cc/120?img=55'),
      FavoritePerson(name: 'Rick Smith', subtitle: 'Founder and CEO, Axon', imageUrl: 'https://i.pravatar.cc/120?img=22'),
      FavoritePerson(name: 'Melissa Clark', subtitle: 'New York Times Food Writer', imageUrl: 'https://i.pravatar.cc/120?img=68'),
      FavoritePerson(name: 'Khajak Keledjian', subtitle: 'Founder of Inscape', imageUrl: 'https://i.pravatar.cc/120?img=29'),
      FavoritePerson(name: 'Lisa Nicole Bell', subtitle: 'Writer, Producer', imageUrl: 'https://i.pravatar.cc/120?img=57'),
      FavoritePerson(name: 'John Zeratsky', subtitle: 'Author, Designer', imageUrl: 'https://i.pravatar.cc/120?img=41'),
    ],
    this.padding = const EdgeInsets.symmetric(vertical: 24.0),
    this.cardHeight = 110,
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
              : (screenWidth < 1200 ? 980.0 : 1100.0);
          // Columns: 1 (narrow) / 2 (medium) / 3 (wide)
          final crossAxisCount = screenWidth < 700
              ? 1
              : (screenWidth < 1100 ? 2 : 3);
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 28,
                  mainAxisExtent: cardHeight,
                ),
                itemCount: people.length,
                itemBuilder: (context, index) {
                  final p = people[index];
                  return _HoverCard(
                    child: _PersonCard(person: p),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HoverCard extends StatefulWidget {
  final Widget child;
  const _HoverCard({required this.child});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _hovering ? const Color(0xFFFFF3E8) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _hovering ? _kOrange : const Color(0xFFE6E6E6)),
          boxShadow: _hovering
              ? const [
                  BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2))
                ]
              : const [
                  BoxShadow(color: Colors.transparent)
                ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: widget.child,
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  final FavoritePerson person;
  const _PersonCard({required this.person});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
  _Avatar(asset: person.asset, imageUrl: person.imageUrl, name: person.name),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                person.name,
                style: const TextStyle(
                  color: _kOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                person.subtitle,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.55),
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? asset;
  final String? imageUrl;
  final String name;
  const _Avatar({required this.asset, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = _initialsFromName(name);
    final bg = const Color(0xFFE6E6E6);
    final borderColor = Colors.white;

    Widget avatar;
    if (asset != null) {
      avatar = CircleAvatar(
        radius: 28,
        backgroundColor: bg,
        foregroundColor: Colors.black87,
        backgroundImage: AssetImage(asset!),
      );
    } else if (imageUrl != null) {
      avatar = CircleAvatar(
        radius: 28,
        backgroundColor: bg,
        foregroundColor: Colors.black87,
        backgroundImage: NetworkImage(imageUrl!),
      );
    } else {
      avatar = CircleAvatar(
        radius: 28,
        backgroundColor: bg,
        foregroundColor: Colors.black87,
        child: Text(
          initials,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: borderColor,
        child: avatar,
      ),
    );
  }

  String _initialsFromName(String n) {
    final parts = n.trim().split(RegExp(r"\s+"));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    final first = parts.first;
    final last = parts.last;
    return (first.isNotEmpty ? first[0] : '') + (last.isNotEmpty ? last[0] : '');
  }
}
