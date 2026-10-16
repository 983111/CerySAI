import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.dark,
      body: SafeArea(
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 50),
          const LeafLogo(size: 26, color: Colors.white),
          const Text('CerySAI',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 50),
          const Text('Listening...', style: TextStyle(color: Colors.white, fontSize: 20)),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            _Wave([18, 30, 44, 26, 16]),
            SizedBox(width: 12),
            _MicOrb(),
            SizedBox(width: 12),
            _Wave([16, 26, 44, 30, 18]),
          ]),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text('Tap to stop',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}

class _MicOrb extends StatelessWidget {
  const _MicOrb();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white12),
      ),
      child: Center(
        child: Container(
          width: 104,
          height: 104,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: C.dark,
            border: Border.all(color: Colors.white70, width: 1.5),
          ),
          child: const Icon(Icons.mic_none_rounded, color: Colors.white, size: 44),
        ),
      ),
    );
  }
}

class _Wave extends StatelessWidget {
  final List<double> heights;
  const _Wave(this.heights);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      for (final h in heights)
        Container(
          width: 2.5,
          height: h,
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          decoration: BoxDecoration(
            color: const Color(0xFF3FA37A),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
    ]);
  }
}
