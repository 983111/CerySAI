import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFBFAF4),
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: h * 0.55,
          child: Stack(fit: StackFit.expand, children: [
            const Pic('field.jpg'),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFBFAF4), Color(0x00FBFAF4), Color(0x66000000)],
                  stops: [0, 0.35, 1],
                ),
              ),
            ),
          ]),
        ),
        SafeArea(
          child: Column(children: [
            SizedBox(height: h * 0.16),
            const LeafLogo(size: 54),
            const Text('CerySAI',
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: C.dark)),
            const SizedBox(height: 14),
            const Text('Smarter Farming\nfor a Brighter Tomorrow',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: C.text, height: 1.35)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: PrimaryButton(
                'Get Started',
                // arguments: true => language screen continues to Sign Up
                onTap: () => Navigator.pushNamed(context, R.language, arguments: true),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, R.login),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Already have an account? Log In',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 28),
          ]),
        ),
      ]),
    );
  }
}
