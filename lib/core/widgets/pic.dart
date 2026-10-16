import 'package:flutter/material.dart';

/// Loads assets/images/<name>; falls back to a green gradient if missing.
class Pic extends StatelessWidget {
  final String name;
  final double? w, h;
  final BoxFit fit;
  const Pic(this.name, {super.key, this.w, this.h, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$name',
      width: w,
      height: h,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8DB35F), Color(0xFF2F5D34)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
