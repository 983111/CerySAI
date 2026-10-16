import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';
import 'feature_data.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        const TopBar('Explore', back: false),
        Expanded(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            for (final f in kFeatures)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, f.route),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: C.line),
                  ),
                  leading: IconBadge(f.icon, bg: f.color.withValues(alpha: 0.14), fg: f.color, size: 40),
                  title: Text(f.title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  subtitle: Text(f.sub.replaceAll('\n', ' '),
                      style: const TextStyle(fontSize: 11, color: C.sub)),
                  trailing: const Icon(Icons.chevron_right, color: C.sub),
                ),
              ),
          ]),
        ),
      ]),
    );
  }
}
