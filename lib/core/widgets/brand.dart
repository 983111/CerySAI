import 'package:flutter/material.dart';

import '../theme.dart';

class LeafLogo extends StatelessWidget {
  final double size;
  final Color color;
  const LeafLogo({super.key, this.size = 56, this.color = C.green});

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.eco_rounded, size: size, color: color);
}

class IconBadge extends StatelessWidget {
  final IconData icon;
  final Color bg, fg;
  final double size;
  const IconBadge(this.icon,
      {super.key, this.bg = C.mint, this.fg = C.green, this.size = 44});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: fg, size: size * 0.5),
      );
}
