import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _location = TextEditingController();
  final _land = TextEditingController();
  bool _hide = true;
  bool _loading = false;

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _confirm, _location, _land]) {
      c.dispose();
    }
    super.dispose();
  }

  void _toast(String m) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(m)));

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.instance.signUp(
        name: _name.text,
        email: _email.text,
        password: _password.text,
        location: _location.text,
        landAcres: double.parse(_land.text),
      );
      if (!mounted) return;
      // AuthGate (root) switches to Home automatically; clear pushed screens.
      Navigator.of(context).popUntil((r) => r.isFirst);
    } on FirebaseAuthException catch (e) {
      _toast(AuthService.friendly(e));
    } on FirebaseException catch (e) {
      // e.g. Firestore rules not published yet
      _toast('Could not save your profile (${e.code}). Check Firestore rules.');
    } catch (e) {
      _toast('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Create Account'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _form,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Tell us about you and your farm',
                      style: TextStyle(fontSize: 12, color: C.sub)),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _name,
                    label: 'Full name',
                    hint: 'Your name',
                    icon: Icons.person_outline_rounded,
                    capitalization: TextCapitalization.words,
                    autofill: const [AutofillHints.name],
                    validator: (v) =>
                        (v == null || v.trim().length < 2) ? 'Enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _email,
                    label: 'Email',
                    hint: 'you@example.com',
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    autofill: const [AutofillHints.email],
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t);
                      return ok ? null : 'Enter a valid email';
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _location,
                    label: 'Location',
                    hint: 'Village / Town, District, State',
                    icon: Icons.location_on_outlined,
                    capitalization: TextCapitalization.words,
                    validator: (v) =>
                        (v == null || v.trim().length < 3) ? 'Enter your location' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _land,
                    label: 'Land size',
                    hint: 'e.g. 2.5',
                    icon: Icons.landscape_outlined,
                    suffixText: 'acres',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    formatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                    validator: (v) {
                      final n = double.tryParse(v ?? '');
                      if (n == null || n <= 0) return 'Enter land size in acres';
                      if (n > 100000) return 'Please enter a realistic value';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _password,
                    label: 'Create password',
                    hint: 'At least 6 characters',
                    icon: Icons.lock_outline_rounded,
                    obscure: _hide,
                    suffix: IconButton(
                      icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 20, color: C.sub),
                      onPressed: () => setState(() => _hide = !_hide),
                    ),
                    validator: (v) =>
                        (v == null || v.length < 6) ? 'Use at least 6 characters' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _confirm,
                    label: 'Confirm password',
                    hint: 'Re-enter password',
                    icon: Icons.lock_outline_rounded,
                    obscure: _hide,
                    action: TextInputAction.done,
                    validator: (v) => v != _password.text ? 'Passwords do not match' : null,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('By creating an account you agree to our ',
                          style: TextStyle(fontSize: 11, color: C.sub)),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, R.terms),
                        child: const Text('Terms of Service',
                            style: TextStyle(
                                fontSize: 11, color: C.green, fontWeight: FontWeight.w700)),
                      ),
                      const Text(' and ', style: TextStyle(fontSize: 11, color: C.sub)),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, R.privacy),
                        child: const Text('Privacy Policy',
                            style: TextStyle(
                                fontSize: 11, color: C.green, fontWeight: FontWeight.w700)),
                      ),
                      const Text('.', style: TextStyle(fontSize: 11, color: C.sub)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton('Create Account', onTap: _submit, loading: _loading),
                  const SizedBox(height: 18),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Already have an account? ',
                        style: TextStyle(fontSize: 12, color: C.sub)),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, R.login),
                      child: const Text('Log In',
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
