import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class LegalSection {
  final String heading;
  final String body;
  const LegalSection(this.heading, this.body);
}

/// Reusable page for Privacy Policy / Terms of Service.
class LegalPage extends StatelessWidget {
  final String title;
  final String intro;
  final List<LegalSection> sections;
  const LegalPage({super.key, required this.title, required this.intro, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          TopBar(title),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(18, 4, 18, 32), children: [
              Text('Last updated: ${AppInfo.legalUpdated}',
                  style: const TextStyle(fontSize: 11, color: C.sub)),
              const SizedBox(height: 12),
              Text(intro, style: const TextStyle(fontSize: 12, height: 1.6)),
              for (var i = 0; i < sections.length; i++) ...[
                const SizedBox(height: 20),
                Text('${i + 1}. ${sections[i].heading}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(sections[i].body,
                    style: const TextStyle(fontSize: 12, color: C.text, height: 1.6)),
              ],
            ]),
          ),
        ]),
      ),
    );
  }
}
