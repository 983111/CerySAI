import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'core/theme.dart';
import 'features/auth/auth_gate.dart';

class CerySaiApp extends StatelessWidget {
  const CerySaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CerySAI',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const AuthGate(), // decides: Splash (logged out) or Home (logged in)
      routes: appRoutes,
    );
  }
}
