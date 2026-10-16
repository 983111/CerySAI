import 'package:cloud_firestore/cloud_firestore.dart';

/// Farmer profile stored in Firestore at users/{uid}.
class AppUser {
  final String uid;
  final String name;
  final String email;
  final String location;
  final double landAcres;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.location,
    required this.landAcres,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'location': location,
        'landAcres': landAcres,
        'createdAt': FieldValue.serverTimestamp(),
      };

  factory AppUser.fromMap(String uid, Map<String, dynamic> m) => AppUser(
        uid: uid,
        name: (m['name'] ?? '') as String,
        email: (m['email'] ?? '') as String,
        location: (m['location'] ?? '') as String,
        landAcres: ((m['landAcres'] ?? 0) as num).toDouble(),
      );
}
