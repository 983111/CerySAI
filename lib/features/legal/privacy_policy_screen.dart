import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'legal_page.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPage(
      title: 'Privacy Policy',
      intro: '${AppInfo.name} is developed and operated by ${AppInfo.company} ("we", "us"). '
          'This policy explains what information we collect, why we collect it and how we protect it. '
          'By using the app you agree to this policy.',
      sections: [
        LegalSection(
          'Information we collect',
          'Account information: your name, email address and password. Your password is handled by '
              'Google Firebase Authentication and we cannot see it.\n\n'
              'Farm information: your location and land size in acres, which you give us when you sign up.\n\n'
              'Content you share: questions you ask the AI assistant, and any photos or voice input you '
              'submit when you use features such as Plant Doctor or voice chat.\n\n'
              'App information: your language choice, device type, app version and basic diagnostic '
              'information that helps us fix errors.',
        ),
        LegalSection(
          'How we use your information',
          '- To create and secure your account, and to verify your email.\n'
              '- To give you relevant crop recommendations, weather information and scheme suggestions for your area and land size.\n'
              '- To answer your questions and diagnose plant problems.\n'
              '- To improve the accuracy, safety and performance of the app.\n'
              '- To prevent fraud and misuse.\n'
              '- To send you important service messages, such as email verification and password reset.',
        ),
        LegalSection(
          'We do not sell your data',
          'We do not sell or rent your personal information. We do not share it for third-party '
              'advertising. We only share information with service providers who help us run the app '
              '(for example, Google Firebase), when the law requires it, or when you give us permission.',
        ),
        LegalSection(
          'No payments and no financial data',
          '${AppInfo.name} is free. We do not collect bank, card, UPI or other payment information, '
              'and we will never ask you for a payment, an OTP or a PIN.',
        ),
        LegalSection(
          'Storage and security',
          'Your data is stored on Google Firebase / Google Cloud servers. It is protected in transit '
              'with encryption, and access rules are set so that you can only access your own profile. '
              'No system is 100% secure, so please keep your password private.',
        ),
        LegalSection(
          'How long we keep your data',
          'We keep your information while your account is active. If you ask us to delete your account, '
              'we will delete your profile and personal data within 30 days, except where we must keep '
              'something to follow the law.',
        ),
        LegalSection(
          'Your choices and rights',
          'You can ask us to show you the data we hold about you, correct it, or delete it. You can also '
              'withdraw your consent at any time by deleting your account. To make a request, email '
              '${AppInfo.supportEmail} from your registered email address.',
        ),
        LegalSection(
          'Children',
          '${AppInfo.name} is not meant for children under 18. If you think a child has given us their '
              'information, please contact us and we will delete it.',
        ),
        LegalSection(
          'Changes to this policy',
          'We may update this policy from time to time. When we make important changes we will tell you '
              'in the app. The date at the top shows when it was last updated.',
        ),
        LegalSection(
          'Contact us',
          '${AppInfo.company}\nEmail: ${AppInfo.supportEmail}',
        ),
      ],
    );
  }
}
