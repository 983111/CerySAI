import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';
import 'feature_data.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Positioned.fill(
          top: 60,
          child: Stack(fit: StackFit.expand, children: [
            const Pic('field.jpg'),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [C.bg, Color(0x00F8F8F4)],
                  stops: [0.1, 0.9],
                ),
              ),
            ),
          ]),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: const [
                Text('CerySAI',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: C.green)),
                Spacer(),
                Icon(Icons.notifications_none_rounded, color: C.text),
                SizedBox(width: 12),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: C.mint,
                  child: Icon(Icons.person, size: 18, color: C.green),
                ),
              ]),
              const SizedBox(height: 18),
              const Text('Good Morning,\nFarmer!',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800, height: 1.2, color: C.text)),
              const SizedBox(height: 8),
              const Text('Better decisions. Healthier crops.\nHigher yields.',
                  style: TextStyle(fontSize: 13, color: C.text, height: 1.35)),
              const SizedBox(height: 70),
            ]),
          ),
        ),
      ]),
      Expanded(
        child: Transform.translate(
          offset: const Offset(0, -28),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const ClampingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, R.assistant),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: cardDeco(),
                  child: Row(children: const [
                    IconBadge(Icons.eco_rounded, size: 46),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Ask CerySAI',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('Your AI farming assistant',
                            style: TextStyle(fontSize: 11, color: C.sub)),
                      ]),
                    ),
                    Icon(Icons.chevron_right, color: C.sub),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.25,
                children: [for (final f in kFeatures) _FeatureTile(f)],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ]);
  }
}

class _FeatureTile extends StatelessWidget {
  final Feature f;
  const _FeatureTile(this.f);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, f.route),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: cardDeco(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconBadge(f.icon, bg: f.color.withValues(alpha: 0.14), fg: f.color, size: 36),
          const Spacer(),
          Text(f.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(f.sub, style: const TextStyle(fontSize: 10, color: C.sub, height: 1.3)),
        ]),
      ),
    );
  }
}
