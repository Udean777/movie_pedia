import 'package:flutter/material.dart';

/// **NavigationSignButton** adalah sebuah widget tombol navigasi berbasis teks.
///
/// Tombol ini digunakan untuk menampilkan dua bagian teks dengan gaya yang berbeda,
/// biasanya digunakan dalam layar autentikasi seperti **Sign In / Sign Up**.
///
/// **Fitur utama:**
/// - **Mendukung navigasi** melalui callback `onPressed`.
/// - **Menampilkan dua teks** dengan format berbeda menggunakan `RichText`.
/// - **Menggunakan `TextSpan`** untuk membedakan warna dan gaya dari dua bagian teks.
///
/// **Parameter:**
/// - `onPressed`: Callback opsional yang dipanggil ketika tombol ditekan.
/// - `text`: Teks utama yang biasanya merupakan informasi tambahan (misalnya: "Belum punya akun?").
/// - `subText`: Teks sekunder yang menekankan tindakan (misalnya: "Daftar sekarang").
///
/// **Contoh Penggunaan:**
/// ```dart
/// NavigationSignButton(
///   text: "Belum punya akun? ",
///   subText: "Daftar sekarang",
///   onPressed: () {
///     // Navigasi ke halaman pendaftaran
///   },
/// )
/// ```
class NavigationSignButton extends StatelessWidget {
  /// Callback yang akan dijalankan ketika tombol ditekan.
  final void Function()? onPressed;

  /// Teks utama yang biasanya berupa informasi tambahan.
  final String text;

  /// Teks sekunder yang menekankan tindakan utama.
  final String subText;

  /// Konstruktor untuk `NavigationSignButton`.
  ///
  /// - `text` dan `subText` bersifat wajib (required).
  /// - `onPressed` bersifat opsional.
  const NavigationSignButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      /// Menjalankan fungsi `onPressed` saat tombol ditekan.
      onPressed: onPressed,

      /// Menggunakan `RichText` untuk menampilkan teks dengan dua gaya berbeda.
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16), // Gaya default teks

          children: [
            /// `text` akan ditampilkan dengan warna putih semi-transparan.
            TextSpan(
              text: text,
              style: const TextStyle(color: Colors.white70),
            ),

            /// `subText` akan ditampilkan dengan warna putih dan bold untuk menonjolkan aksi.
            TextSpan(
              text: subText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
