import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../services/auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  static const _cooldownSeconds = 60;
  Timer? _poll;
  Timer? _cool;
  int _cooldown = 0;
  bool _checking = false;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    // Quietly check every 3 seconds; AuthGate moves to Home once verified.
    _poll = Timer.periodic(
        const Duration(seconds: 3), (_) => AuthService.instance.refreshVerification());
  }

  @override
  void dispose() {
    _poll?.cancel();
    _cool?.cancel();
    super.dispose();
  }

  void _toast(String m) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(m)));

  Future<void> _check() async {
    setState(() => _checking = true);
    final ok = await AuthService.instance.refreshVerification();
    if (!mounted) return;
    setState(() => _checking = false);
    if (!ok) _toast('Your email is not verified yet. Please tap the link in the email.');
  }

  Future<void> _resend() async {
    if (_cooldown > 0 || _sending) return;
    setState(() => _sending = true);
    try {
      await AuthService.instance.sendVerificationEmail();
      if (!mounted) return;
      _toast('Verification email sent. Check your inbox and spam folder.');
      setState(() => _cooldown = _cooldownSeconds);
      _cool?.cancel();
      _cool = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!mounted) return t.cancel();
        setState(() => _cooldown--);
        if (_cooldown <= 0) t.cancel();
      });
    } on FirebaseAuthException catch (e) {
      _toast(AuthService.friendly(e));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _logout() async {
    final ok = await confirmDialog(
      context,
      title: 'Log out?',
      message: 'You can log in again, or create a new account with a different email.',
      confirmLabel: 'Log Out',
      destructive: true,
    );
    if (ok) await AuthService.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final email = AuthService.instance.currentUser?.email ?? 'your email';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const Spacer(),
            Container(
              width: 92,
              height: 92,
              decoration: const BoxDecoration(color: C.mint, shape: BoxShape.circle),
              child: const Icon(Icons.mark_email_unread_outlined, size: 44, color: C.green),
            ),
            const SizedBox(height: 24),
            const Text('Verify your email',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Text('We sent a verification link to',
                style: const TextStyle(fontSize: 13, color: C.sub)),
            const SizedBox(height: 4),
            Text(email,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            const Text(
                'Open the email and tap the link. Then come back here. '
                "If you can't find it, check your spam folder.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: C.sub, height: 1.5)),
            const SizedBox(height: 28),
            PrimaryButton("I've verified my email", onTap: _check, loading: _checking),
            const SizedBox(height: 10),
            TextButton(
              onPressed: (_cooldown > 0 || _sending) ? null : _resend,
              child: Text(
                _cooldown > 0 ? 'Resend email in ${_cooldown}s' : 'Resend verification email',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _cooldown > 0 ? C.sub : C.green),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: _logout,
              child: const Text('Wrong email? Log out',
                  style: TextStyle(fontSize: 12, color: C.sub)),
            ),
            const SizedBox(height: 12),
          ]),
        ),
      ),
    );
  }
}
