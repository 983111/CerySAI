import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class _BracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    const l = 30.0;
    final path = Path()
      ..moveTo(0, l)..lineTo(0, 0)..lineTo(l, 0)
      ..moveTo(s.width - l, 0)..lineTo(s.width, 0)..lineTo(s.width, l)
      ..moveTo(0, s.height - l)..lineTo(0, s.height)..lineTo(l, s.height)
      ..moveTo(s.width - l, s.height)..lineTo(s.width, s.height)..lineTo(s.width, s.height - l);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class PlantDoctorScreen extends StatelessWidget {
  const PlantDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('AI Plant Doctor'),
          Expanded(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 14), children: [
              const _ScanCard(),
              const SizedBox(height: 18),
              Row(children: const [
                Text('Recent Detections',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                Spacer(),
                Text('View all', style: TextStyle(fontSize: 11, color: C.green)),
              ]),
              const SizedBox(height: 10),
              const _DetectionTile(),
              const SizedBox(height: 14),
              const _TreatmentCard(),
              const SizedBox(height: 16),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _ScanCard extends StatelessWidget {
  const _ScanCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 270,
        child: Stack(fit: StackFit.expand, children: [
          const Pic('leaf.jpg'),
          Container(color: Colors.black.withValues(alpha: 0.18)),
          Positioned(
            left: 26, right: 26, top: 22, bottom: 56,
            child: CustomPaint(painter: _BracketPainter()),
          ),
          Align(
            alignment: const Alignment(0, 0.62),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: C.dark.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white54),
              ),
              child: const Icon(Icons.photo_camera_outlined, color: Colors.white, size: 22),
            ),
          ),
          const Align(
            alignment: Alignment(0, 0.93),
            child: Text('Tap to capture or upload image',
                style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ]),
      ),
    );
  }
}

class _DetectionTile extends StatelessWidget {
  const _DetectionTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: cardDeco(14),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const Pic('tomato.jpg', w: 60, h: 60),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Tomato Leaf Blight',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: C.alert,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: C.red, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                const Text('Disease', style: TextStyle(fontSize: 10, color: C.red)),
              ]),
            ),
            const SizedBox(height: 4),
            const Text('Early stage', style: TextStyle(fontSize: 11, color: C.sub)),
          ]),
        ),
        const Icon(Icons.chevron_right, color: C.sub),
      ]),
    );
  }
}

class _TreatmentCard extends StatelessWidget {
  const _TreatmentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: C.mint, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Row(children: [
              Icon(Icons.medical_services_outlined, size: 15, color: C.green),
              SizedBox(width: 6),
              Text('Recommended Treatment',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ]),
            SizedBox(height: 8),
            _Bullet('Remove affected leaves'),
            _Bullet('Use copper-based fungicide'),
            _Bullet('Improve air circulation'),
          ]),
        ),
        const Icon(Icons.chevron_right, color: C.sub),
      ]),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String t;
  const _Bullet(this.t);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(children: [
          Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(color: C.text, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(t, style: const TextStyle(fontSize: 11, color: C.text)),
        ]),
      );
}
