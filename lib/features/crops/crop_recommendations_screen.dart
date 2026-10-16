import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class CropRecommendationsScreen extends StatelessWidget {
  const CropRecommendationsScreen({super.key});

  static const _crops = [
    ['Soybean', 'Good for your soil type', 'soybean.jpg'],
    ['Pigeon Pea (Tur)', 'High demand in your region', 'pigeonpea.jpg'],
    ['Chickpea', 'Suitable for current weather', 'chickpea.jpg'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Crop Recommendations'),
          Expanded(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 14), children: [
              const _Hero(),
              const SizedBox(height: 12),
              const _LocationCard(),
              const SizedBox(height: 16),
              const Text('Top Recommendations',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              for (final c in _crops) _CropTile(c[0], c[1], c[2]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 160,
        child: Stack(fit: StackFit.expand, children: [
          const Pic('crops_hero.jpg'),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0xAA000000)],
              ),
            ),
          ),
          const Positioned(
            left: 14,
            bottom: 12,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recommended Crops\nfor Your Land',
                  style: TextStyle(
                      color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800, height: 1.2)),
              SizedBox(height: 4),
              Text('Based on soil, weather and location',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: cardDeco(12),
      child: Row(children: const [
        Icon(Icons.location_on, size: 18, color: C.green),
        SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Your Location', style: TextStyle(fontSize: 9, color: C.sub)),
            Text('Parbhani, Maharashtra',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
          ]),
        ),
        Text('Change',
            style: TextStyle(fontSize: 11, color: C.green, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class _CropTile extends StatelessWidget {
  final String title, sub, image;
  const _CropTile(this.title, this.sub, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: cardDeco(12),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(8), child: Pic(image, w: 48, h: 48)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(sub, style: const TextStyle(fontSize: 10, color: C.sub)),
          ]),
        ),
        const Icon(Icons.chevron_right, color: C.sub),
      ]),
    );
  }
}
