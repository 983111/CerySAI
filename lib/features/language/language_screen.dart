import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _sel = 0;
  static const _langs = ['English', 'हिंदी', 'मराठी', 'ગુજરાતી', 'தமிழ்', 'తెలుగు', 'ಕನ್ನಡ'];

  @override
  Widget build(BuildContext context) {
    // true when opened from Splash -> Get Started (onboarding)
    final onboarding = ModalRoute.of(context)?.settings.arguments == true;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Select Language'),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Choose your preferred language\nfor voice and text.',
                  style: TextStyle(fontSize: 12, color: C.text, height: 1.4)),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: cardDeco(12),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                itemCount: _langs.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: C.line),
                itemBuilder: (_, i) => InkWell(
                  onTap: () => setState(() => _sel = i),
                  child: Container(
                    color: _sel == i ? C.bg : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    child: Row(children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: _sel == i ? C.dark : Colors.black26,
                              width: _sel == i ? 5 : 1.4),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(_langs[i],
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: PrimaryButton('Continue', onTap: () {
              if (onboarding) {
                Navigator.pushReplacementNamed(context, R.signup);
              } else {
                Navigator.pop(context);
              }
            }),
          ),
        ]),
      ),
    );
  }
}
