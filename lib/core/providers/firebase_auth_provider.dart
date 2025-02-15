import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/services/auth_service.dart';

/// Provider untuk mengelola instance FirebaseAuth.
/// Menggunakan instance default dari FirebaseAuth.
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

/// Provider untuk layanan autentikasi.
/// Menggunakan `firebaseAuthProvider` sebagai dependensi.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(firebaseAuthProvider));
});

/// StreamProvider yang memantau perubahan status autentikasi pengguna.
/// Akan memberikan nilai `User?`, di mana:
/// - `User` jika pengguna sedang login.
/// - `null` jika pengguna belum login atau logout.
final authStateNotifierProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});
