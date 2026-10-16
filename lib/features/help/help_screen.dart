import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants.dart';
import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const _faqs = [
    [
      'How do I verify my email?',
      'After you create an account we email you a link. Open the email, tap the link, then return to the app. '
          "If you can't see it, check your spam folder or tap 'Resend verification email'."
    ],
    [
      'I forgot my password',
      "On the Log In screen, type your email and tap 'Forgot password?'. "
          'We will send you a link to set a new password.'
    ],
    [
      'How do I change the language?',
      'Go to Profile > Language, choose your language and tap Continue.'
    ],
    [
      'How do I update my location or land size?',
      'Email us at ${AppInfo.supportEmail} with your new details and we will update them for you.'
    ],
    [
      'How accurate are the plant and crop results?',
      'CerySAI gives AI-based guidance. It can make mistakes, so for serious crop problems please also '
          'consult your local agriculture officer or Krishi Vigyan Kendra (KVK).'
    ],
    [
      'Is CerySAI really free?',
      'Yes. CerySAI is free to use and we never ask you for money, bank details, UPI PIN, card numbers or OTPs.'
    ],
    [
      'How do I delete my account?',
      'Email ${AppInfo.supportEmail} from your registered email address with the subject '
          "'Delete my account'. We will remove your account and data."
    ],
  ];

  void _copy(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: AppInfo.supportEmail));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Email address copied')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Help & Support'),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(14, 4, 14, 24), children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: cardDeco(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: const [
                    IconBadge(Icons.support_agent_rounded, size: 42),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Need help? We are here.',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                        SizedBox(height: 2),
                        Text('We usually reply within 1-2 working days.',
                            style: TextStyle(fontSize: 11, color: C.sub)),
                      ]),
                    ),
                  ]),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration:
                        BoxDecoration(color: C.mint, borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      const Icon(Icons.mail_outline_rounded, size: 18, color: C.green),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(AppInfo.supportEmail,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      ),
                      GestureDetector(
                        onTap: () => _copy(context),
                        child: const Row(children: [
                          Icon(Icons.copy_rounded, size: 16, color: C.green),
                          SizedBox(width: 4),
                          Text('Copy',
                              style: TextStyle(
                                  fontSize: 12, color: C.green, fontWeight: FontWeight.w700)),
                        ]),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                      'When you write to us, please include your registered email, the screen '
                      'where the problem happened, and your phone model. A screenshot helps a lot.',
                      style: TextStyle(fontSize: 11, color: C.sub, height: 1.5)),
                ]),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text('Frequently asked questions',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              ),
              Container(
                decoration: cardDeco(14),
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  for (var i = 0; i < _faqs.length; i++) ...[
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
                        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        iconColor: C.green,
                        title: Text(_faqs[i][0],
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                        children: [
                          Text(_faqs[i][1],
                              style: const TextStyle(fontSize: 12, color: C.sub, height: 1.5)),
                        ],
                      ),
                    ),
                    if (i != _faqs.length - 1) const Divider(height: 1, color: C.line),
                  ],
                ]),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration:
                    BoxDecoration(color: C.alert, borderRadius: BorderRadius.circular(12)),
                child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.shield_outlined, color: C.red, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        'Stay safe: CerySAI will never ask you for money, bank details, UPI PIN, '
                        'card numbers, OTPs or your password. If someone does in our name, do not '
                        'share anything and report it to ${AppInfo.supportEmail}.',
                        style: TextStyle(fontSize: 11, height: 1.5)),
                  ),
                ]),
              ),
              const SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, R.privacy),
                  child: const Text('Privacy Policy',
                      style: TextStyle(fontSize: 11, color: C.green, fontWeight: FontWeight.w600)),
                ),
                const Text('   |   ', style: TextStyle(fontSize: 11, color: C.sub)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, R.terms),
                  child: const Text('Terms of Service',
                      style: TextStyle(fontSize: 11, color: C.green, fontWeight: FontWeight.w600)),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}
