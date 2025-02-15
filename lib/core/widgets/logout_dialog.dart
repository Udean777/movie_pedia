import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart'; // Pastikan Anda mengimpor Riverpod jika Anda menggunakannya

/// **LogoutDialog** adalah sebuah kelas utilitas yang menyediakan dialog konfirmasi logout.
///
/// Dialog ini muncul sebagai pop-up konfirmasi ketika pengguna ingin keluar dari akun mereka.
/// Menggunakan **Riverpod** untuk membaca layanan autentikasi dan melakukan proses logout.
///
/// **Cara Kerja:**
/// 1. Memanggil `showDialog()` untuk menampilkan dialog konfirmasi.
/// 2. Menyediakan dua opsi tombol:
///    - **Cancel** → Menutup dialog tanpa melakukan logout.
///    - **Logout** → Memanggil fungsi `signOut()` dari `authServiceProvider`, lalu menutup dialog.
///
/// **Parameter:**
/// - `context`: (BuildContext) Konteks UI untuk menampilkan dialog.
/// - `ref`: (WidgetRef) Referensi untuk membaca provider dari Riverpod.
///
/// **Contoh Penggunaan:**
/// ```dart
/// LogoutDialog.show(context, ref);
/// ```
class LogoutDialog {
  /// Menampilkan dialog konfirmasi logout.
  ///
  /// Dialog ini berisi pesan konfirmasi dan dua tombol aksi:
  /// - **Cancel**: Menutup dialog tanpa logout.
  /// - **Logout**: Melakukan proses logout dan menutup dialog.
  ///
  /// - `context` → Digunakan untuk menampilkan dialog dalam tree widget.
  /// - `ref` → Digunakan untuk mengakses `authServiceProvider` dari Riverpod.
  static Future<void> show(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context, // Menentukan konteks untuk menampilkan dialog.
      builder: (BuildContext context) {
        return AlertDialog(
          /// Judul dialog konfirmasi logout.
          title: const Text('Konfirmasi Logout'),

          /// Isi dialog yang memberikan informasi kepada pengguna.
          content: const Text('Apakah Anda yakin ingin logout?'),

          /// Daftar aksi dalam bentuk tombol yang bisa dipilih oleh pengguna.
          actions: <Widget>[
            /// Tombol "Cancel" untuk menutup dialog tanpa melakukan logout.
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                /// Menutup dialog saat tombol "Cancel" ditekan.
                Navigator.of(context).pop();
              },
            ),

            /// Tombol "Logout" untuk melakukan logout.
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                /// Memanggil fungsi `signOut()` dari `authServiceProvider` untuk keluar dari akun.
                ref.read(authServiceProvider).signOut();

                /// Menutup dialog setelah logout berhasil.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
