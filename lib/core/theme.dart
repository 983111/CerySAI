import 'package:flutter/material.dart';

class C {
  static const green = Color(0xFF1B5E43);
  static const dark = Color(0xFF14483A);
  static const bg = Color(0xFFF8F8F4);
  static const text = Color(0xFF1C2A24);
  static const sub = Color(0xFF7A857F);
  static const line = Color(0xFFEAEAE4);
  static const mint = Color(0xFFE6F0E9);
  static const red = Color(0xFFD93A2B);
  static const alert = Color(0xFFFCEDE6);
}

BoxDecoration cardDeco([double r = 16, Color? color]) => BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(r),
      border: Border.all(color: C.line),
      boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4))
      ],
    );

ThemeData buildTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: C.bg,
      colorScheme: ColorScheme.fromSeed(seedColor: C.green, primary: C.green),
      appBarTheme: const AppBarTheme(backgroundColor: C.bg, elevation: 0),
    );
