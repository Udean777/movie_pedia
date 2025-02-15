import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';
import 'package:movie_pedia/main_page.dart';
import 'package:movie_pedia/presentation/auth/signin_page.dart';

/// `AuthWrapper` adalah widget yang berfungsi sebagai pembungkus (wrapper)
/// untuk menentukan tampilan awal berdasarkan status autentikasi pengguna.
///
/// Widget ini menggunakan `ConsumerWidget` dari Riverpod untuk membaca status autentikasi
/// dari `authStateNotifierProvider`. Berdasarkan status tersebut, widget akan menampilkan:
/// - `MainPage()` jika pengguna sudah masuk (authenticated).
/// - `SigninPage()` jika pengguna belum masuk (not authenticated).
/// - Indikator loading jika status autentikasi masih dalam proses.
/// - Pesan error jika terjadi kesalahan dalam memeriksa autentikasi.
///
/// **Penggunaan utama:**
/// - Widget ini sering digunakan dalam `MaterialApp` untuk menentukan halaman pertama yang ditampilkan.
///
/// **Riverpod digunakan untuk:**
/// - Mengawasi perubahan status autentikasi secara reaktif.
/// - Menampilkan UI yang sesuai dengan status autentikasi.

class AuthWrapper extends ConsumerWidget {
  /// Konstruktor `AuthWrapper`
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// `authState` mengawasi perubahan status autentikasi menggunakan Riverpod.
    final authState = ref.watch(authStateNotifierProvider);

    /// `authState.when` menangani tiga kemungkinan status autentikasi:
    return authState.when(
      /// **Jika data tersedia (autentikasi sukses atau pengguna tidak ada)**:
      /// - Jika `user != null`, tampilkan `MainPage` (pengguna masuk).
      /// - Jika `user == null`, tampilkan `SigninPage` (pengguna belum masuk).
      data: (user) => user != null ? const MainPage() : const SigninPage(),

      /// **Jika status masih dalam proses loading**, tampilkan indikator loading.
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      /// **Jika terjadi error**, tampilkan pesan error.
      error: (error, _) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
