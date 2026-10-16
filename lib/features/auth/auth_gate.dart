import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../services/auth_service.dart';
import '../home/main_shell.dart';
import 'splash_screen.dart';
import 'verify_email_screen.dart';

/// Root widget:
///   logged out            -> Splash
///   logged in, unverified -> Verify Email
///   logged in, verified   -> Home
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService.instance;
    return ValueListenableBuilder<int>(
      valueListenable: auth.authTick,
      builder: (context, _, __) => StreamBuilder<User?>(
        stream: auth.userChanges,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: C.green)),
            );
          }
          final user = auth.currentUser ?? snap.data;
          if (user == null) return const SplashScreen();
          return user.emailVerified ? const MainShell() : const VerifyEmailScreen();
        },
      ),
    );
  }
}
