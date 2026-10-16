import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../models/app_user.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final ok = await confirmDialog(
      context,
      title: 'Log out?',
      message: 'Are you sure you want to log out of CerySAI?',
      confirmLabel: 'Log Out',
      destructive: true,
    );
    if (ok) await AuthService.instance.signOut(); // AuthGate returns to Splash
  }

  void _showFarm(BuildContext context, AppUser? u) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Farm Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.location_on_outlined, color: C.green),
                title: const Text('Location', style: TextStyle(fontSize: 11, color: C.sub)),
                subtitle: Text(u?.location.isNotEmpty == true ? u!.location : '—',
                    style: const TextStyle(fontSize: 14, color: C.text)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.landscape_outlined, color: C.green),
                title: const Text('Land size', style: TextStyle(fontSize: 11, color: C.sub)),
                subtitle: Text(u != null ? '${u.landAcres} acres' : '—',
                    style: const TextStyle(fontSize: 14, color: C.text)),
              ),
            ]),
      ),
    );
  }

  Widget _row(IconData i, String t, VoidCallback onTap) => Column(children: [
        ListTile(
          onTap: onTap,
          dense: true,
          leading: Icon(i, size: 20, color: C.text),
          title: Text(t, style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.chevron_right, size: 20, color: C.sub),
        ),
        const Divider(height: 1, color: C.line),
      ]);

  @override
  Widget build(BuildContext context) {
    final auth = AuthService.instance;
    final fbUser = auth.currentUser;

    return StreamBuilder<AppUser?>(
      stream: fbUser == null ? const Stream.empty() : auth.profileStream(fbUser.uid),
      builder: (context, snap) {
        final u = snap.data;
        final name = u?.name.isNotEmpty == true ? u!.name : (fbUser?.displayName ?? 'Farmer');
        final email = u?.email.isNotEmpty == true ? u!.email : (fbUser?.email ?? '');

        return SafeArea(
          child: Column(children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                child: Icon(Icons.settings_outlined, color: C.text.withValues(alpha: 0.8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              child: Row(children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: C.mint,
                  child: Icon(Icons.person, color: C.green, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(email, style: const TextStyle(fontSize: 11, color: C.sub)),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: C.line),
            Expanded(
              child: ListView(padding: EdgeInsets.zero, children: [
                _row(Icons.agriculture_outlined, 'My Farm Details', () => _showFarm(context, u)),
                _row(Icons.language_rounded, 'Language',
                    () => Navigator.pushNamed(context, R.language)),
                _row(Icons.notifications_none_rounded, 'Notifications', () {}),
                _row(Icons.help_outline_rounded, 'Help & Support',
                    () => Navigator.pushNamed(context, R.help)),
                _row(Icons.privacy_tip_outlined, 'Privacy Policy',
                    () => Navigator.pushNamed(context, R.privacy)),
                _row(Icons.description_outlined, 'Terms of Service',
                    () => Navigator.pushNamed(context, R.terms)),
                _row(Icons.info_outline_rounded, 'About CerySAI',
                    () => Navigator.pushNamed(context, R.about)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout_rounded, size: 18, color: C.red),
                  label: const Text('Log Out', style: TextStyle(color: C.red, fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: C.line),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
