import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _promises = [
    ['Free to use', 'CerySAI is free. There are no fees, subscriptions or hidden charges.'],
    [
      'We never ask for money',
      'We will never ask for payments, bank details, UPI PIN, card numbers, OTPs or passwords.'
    ],
    [
      'Your data stays yours',
      'We do not sell your personal information. You can ask us to delete your account any time.'
    ],
    [
      'Guidance you can understand',
      'Advice in your own language, built to support farmers in making better everyday decisions.'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('About CerySAI'),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(14, 8, 14, 24), children: [
              const Center(child: LeafLogo(size: 56)),
              const Center(
                child: Text('CerySAI',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: C.dark)),
              ),
              const SizedBox(height: 2),
              const Center(
                child: Text('Smarter Farming for a Brighter Tomorrow',
                    style: TextStyle(fontSize: 12, color: C.sub)),
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text('Version ${AppInfo.version}',
                    style: TextStyle(fontSize: 11, color: C.sub)),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: cardDeco(16),
                child: Row(children: const [
                  IconBadge(Icons.code_rounded, size: 42),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Developed by', style: TextStyle(fontSize: 11, color: C.sub)),
                      SizedBox(height: 2),
                      Text(AppInfo.company,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                    ]),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              const Text(
                  'CerySAI is an AI farming assistant. It helps you diagnose plant problems, '
                  'choose crops that suit your land, plan with weather forecasts, discover '
                  'government schemes, and get answers to your farming questions.',
                  style: TextStyle(fontSize: 12, color: C.text, height: 1.6)),
              const SizedBox(height: 20),
              const Text('Our promise',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: cardDeco(14),
                child: Column(children: [
                  for (var i = 0; i < _promises.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: i == _promises.length - 1 ? 0 : 14),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Icon(Icons.check_circle_rounded, size: 18, color: C.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(_promises[i][0],
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            Text(_promises[i][1],
                                style: const TextStyle(
                                    fontSize: 11, color: C.sub, height: 1.5)),
                          ]),
                        ),
                      ]),
                    ),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration:
                    BoxDecoration(color: C.alert, borderRadius: BorderRadius.circular(12)),
                child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.warning_amber_rounded, color: C.red, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        'Beware of fraud. If anyone claiming to be from CerySAI asks you for money '
                        'or personal financial details, do not respond. Report it to '
                        '${AppInfo.supportEmail}.',
                        style: TextStyle(fontSize: 11, height: 1.5)),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: cardDeco(14),
                child: Column(children: [
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.mail_outline_rounded, size: 20, color: C.text),
                    title: const Text(AppInfo.supportEmail, style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.copy_rounded, size: 18, color: C.sub),
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: AppInfo.supportEmail));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(content: Text('Email address copied')));
                    },
                  ),
                  const Divider(height: 1, color: C.line),
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.privacy_tip_outlined, size: 20, color: C.text),
                    title: const Text('Privacy Policy', style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right, size: 20, color: C.sub),
                    onTap: () => Navigator.pushNamed(context, R.privacy),
                  ),
                  const Divider(height: 1, color: C.line),
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.description_outlined, size: 20, color: C.text),
                    title: const Text('Terms of Service', style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right, size: 20, color: C.sub),
                    onTap: () => Navigator.pushNamed(context, R.terms),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('Made with care for farmers.\n(c) 2026 ${AppInfo.company}. All rights reserved.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: C.sub, height: 1.5)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
