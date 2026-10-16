import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hide = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _toast(String m) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(m)));

  Future<void> _login() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.instance.signIn(_email.text, _password.text);
      if (!mounted) return;
      // AuthGate (root) switches to Home automatically; clear pushed screens.
      Navigator.of(context).popUntil((r) => r.isFirst);
    } on FirebaseAuthException catch (e) {
      _toast(AuthService.friendly(e));
    } catch (e) {
      _toast('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _forgot() async {
    final email = _email.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      _toast('Enter your email above first, then tap Forgot password.');
      return;
    }
    try {
      await AuthService.instance.sendPasswordReset(email);
      _toast('Password reset link sent to $email');
    } on FirebaseAuthException catch (e) {
      _toast(AuthService.friendly(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Log In'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Form(
                key: _form,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Center(child: LeafLogo(size: 48)),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text('Welcome back',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text('Log in to continue to CerySAI',
                        style: TextStyle(fontSize: 12, color: C.sub)),
                  ),
                  const SizedBox(height: 28),
                  AppTextField(
                    controller: _email,
                    label: 'Email',
                    hint: 'you@example.com',
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    autofill: const [AutofillHints.email],
                    validator: (v) =>
                        (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _password,
                    label: 'Password',
                    hint: 'Your password',
                    icon: Icons.lock_outline_rounded,
                    obscure: _hide,
                    action: TextInputAction.done,
                    suffix: IconButton(
                      icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 20, color: C.sub),
                      onPressed: () => setState(() => _hide = !_hide),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Enter your password' : null,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _forgot,
                      child: const Text('Forgot password?',
                          style: TextStyle(fontSize: 12, color: C.green)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton('Log In', onTap: _login, loading: _loading),
                  const SizedBox(height: 18),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('New to CerySAI? ',
                        style: TextStyle(fontSize: 12, color: C.sub)),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, R.signup),
                      child: const Text('Create account',
                          style: TextStyle(
                              fontSize: 12, color: C.green, fontWeight: FontWeight.w700)),
                    ),
                  ]),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
