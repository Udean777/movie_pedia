import 'package:firebase_auth/firebase_auth.dart';

/// Kelas `AuthService` digunakan untuk mengelola autentikasi pengguna
/// menggunakan Firebase Authentication.
class AuthService {
  /// Instance Firebase Authentication yang digunakan untuk mengelola autentikasi.
  final FirebaseAuth _firebaseAuth;

  /// Konstruktor `AuthService` yang menerima instance `FirebaseAuth`.
  AuthService(this._firebaseAuth);

  /// Method untuk masuk (sign in) dengan email dan password.
  ///
  /// Mengembalikan `UserCredential` jika berhasil, atau melempar exception
  /// jika terjadi kesalahan autentikasi.
  ///
  /// [email] - Email pengguna yang digunakan untuk login.
  /// [password] - Password yang digunakan untuk login.
  ///
  /// Jika terjadi kesalahan, error akan diproses menggunakan `_parseAuthError`.
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Menangani error autentikasi dengan parsing kode error.
      throw _parseAuthError(e);
    }
  }

  /// Method untuk mendaftarkan pengguna baru dengan email dan password.
  ///
  /// Mengembalikan `UserCredential` jika berhasil, atau melempar exception
  /// jika terjadi kesalahan saat pendaftaran.
  ///
  /// [email] - Email yang digunakan untuk registrasi.
  /// [password] - Password yang digunakan untuk registrasi.
  ///
  /// Jika terjadi error, method akan menangani menggunakan `_parseAuthError`.
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Menangani error autentikasi saat registrasi dengan parsing kode error.
      throw _parseAuthError(e);
    }
  }

  /// Method untuk menangani error autentikasi Firebase.
  ///
  /// Menerima objek `FirebaseAuthException` dan mengembalikan pesan error yang lebih user-friendly.
  ///
  /// [e] - Objek `FirebaseAuthException` yang berisi kode error dari Firebase.
  ///
  /// Mengembalikan pesan error yang telah diterjemahkan ke dalam bahasa yang lebih mudah dipahami pengguna.
  String _parseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'weak-password':
        return 'Password terlalu lemah';
      case 'user-not-found':
        return 'Pengguna tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      case 'invalid-email':
        return 'Format email tidak valid';
      default:
        return 'Terjadi kesalahan, silakan coba lagi';
    }
  }

  /// Method untuk keluar dari akun (sign out).
  ///
  /// Menggunakan `signOut()` dari Firebase Authentication untuk mengakhiri sesi pengguna.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
