import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';

/// All Firebase auth + profile logic lives here, so screens stay clean.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Bumped when we manually refresh the user (e.g. email just got verified)
  /// so AuthGate rebuilds and moves to Home.
  final ValueNotifier<int> authTick = ValueNotifier<int>(0);

  Stream<User?> get userChanges => _auth.userChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String location,
    required double landAcres,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
    final user = cred.user!;
    await user.updateDisplayName(name.trim());

    // Send the verification email (don't fail signup if this one hiccups;
    // the user can resend from the verify screen).
    try {
      await user.sendEmailVerification();
    } catch (_) {}

    final profile = AppUser(
      uid: user.uid,
      name: name.trim(),
      email: email.trim(),
      location: location.trim(),
      landAcres: landAcres,
    );
    await _db.collection('users').doc(user.uid).set(profile.toMap());
  }

  Future<void> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  // ---------- Email verification ----------

  Future<void> sendVerificationEmail() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  /// Re-reads the user from Firebase. Returns true if the email is verified.
  Future<bool> refreshVerification() async {
    final u = _auth.currentUser;
    if (u == null) return false;
    try {
      await u.reload();
    } on FirebaseAuthException {
      return false;
    }
    final ok = _auth.currentUser?.emailVerified ?? false;
    if (ok) authTick.value++;
    return ok;
  }

  Future<void> signOut() => _auth.signOut();

  Stream<AppUser?> profileStream(String uid) => _db
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((d) => d.exists ? AppUser.fromMap(d.id, d.data()!) : null);

  /// Turns Firebase error codes into messages a farmer can understand.
  static String friendly(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account with this email already exists. Try logging in.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a few minutes and try again.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      case 'operation-not-allowed':
        return 'Email/Password sign-in is not enabled in Firebase yet.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}
