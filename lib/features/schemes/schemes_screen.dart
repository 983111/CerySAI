import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});
  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  int _chip = 0;
  static const _chips = ['All', 'Crop Support', 'Loan & Credit', 'Insurance'];
  static const _items = [
    ['Pradhan Mantri Kisan Samman Nidhi\n(PM-KISAN)',
      'Income support of ₹6,000 per year\nfor eligible farmers.', Icons.agriculture_rounded],
    ['PM Fasal Bima Yojana',
      'Crop insurance for farmers against\nnatural calamities.', Icons.eco_rounded],
    ['Soil Health Card Scheme',
      'Free soil testing and nutrient\nrecommendations.', Icons.science_rounded],
    ['Kisan Credit Card (KCC)',
      'Easy access to credit for farming needs.', Icons.shield_rounded],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Government Schemes'),
          const _SearchBox(),
          const SizedBox(height: 12),
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: _chips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => _chip = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _chip == i ? C.dark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _chip == i ? C.dark : C.line),
                  ),
                  child: Text(_chips[i],
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _chip == i ? Colors.white : C.sub)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: _items.length,
              itemBuilder: (_, i) => _SchemeTile(
                title: _items[i][0] as String,
                desc: _items[i][1] as String,
                icon: _items[i][2] as IconData,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: C.line),
        ),
        child: Row(children: const [
          Icon(Icons.search, size: 20, color: C.sub),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search schemes...',
                hintStyle: TextStyle(fontSize: 11, color: C.sub),
                border: InputBorder.none,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _SchemeTile extends StatelessWidget {
  final String title, desc;
  final IconData icon;
  const _SchemeTile({required this.title, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: cardDeco(12),
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: C.mint, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: C.green, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 10, color: C.sub, height: 1.35)),
          ]),
        ),
        const Icon(Icons.chevron_right, color: C.sub),
      ]),
    );
  }
}
