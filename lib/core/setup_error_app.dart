import 'package:flutter/material.dart';

import 'theme.dart';

/// Shown only when Firebase has not been configured yet.
class SetupErrorApp extends StatelessWidget {
  final String error;
  const SetupErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.settings_suggest_rounded, size: 48, color: C.green),
                const SizedBox(height: 16),
                const Text('Firebase is not set up yet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                const Text(
                    'Open FIREBASE_SETUP.md and follow the steps, mainly: run '
                    '`flutterfire configure` inside the project folder, then restart the app.',
                    style: TextStyle(fontSize: 13, height: 1.5)),
                const SizedBox(height: 16),
                Text(error,
                    style: const TextStyle(fontSize: 11, color: C.sub, height: 1.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
