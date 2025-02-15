import 'package:flutter/material.dart';

/// **SocialSignButton Widget**
///
/// Widget ini merupakan tombol yang digunakan untuk sign in menggunakan media sosial,
/// seperti Google, Facebook, atau Twitter. Widget ini menampilkan ikon dan teks dalam
/// sebuah tombol yang bisa diklik oleh pengguna.
///
/// **Parameter:**
/// - `onPressed` (VoidCallback): Fungsi yang akan dijalankan ketika tombol ditekan.
/// - `text` (String): Teks yang ditampilkan di dalam tombol.
/// - `backgroundColor` (Color): Warna latar belakang tombol.
/// - `textColor` (Color): Warna teks tombol.
/// - `icon` (Widget): Ikon yang akan ditampilkan sebelum teks pada tombol.
///
/// **Cara Kerja:**
/// 1. Menggunakan `ElevatedButton.icon` untuk membuat tombol dengan ikon.
/// 2. Menyesuaikan gaya tombol menggunakan `ElevatedButton.styleFrom()`, termasuk warna, padding, dan border radius.
/// 3. Menggunakan `SizedBox` dengan `width: double.infinity` agar tombol memenuhi lebar maksimum.
///
/// **Contoh Penggunaan:**
/// ```dart
/// SocialSignButton(
///   onPressed: () {
///     print("Login dengan Google");
///   },
///   text: "Sign in with Google",
///   backgroundColor: Colors.white,
///   textColor: Colors.black,
///   icon: Icon(Icons.login, color: Colors.red),
/// )
/// ```
class SocialSignButton extends StatelessWidget {
  /// Fungsi callback yang akan dijalankan saat tombol ditekan.
  final VoidCallback onPressed;

  /// Teks yang akan ditampilkan di dalam tombol.
  final String text;

  /// Warna latar belakang tombol.
  final Color backgroundColor;

  /// Warna teks tombol.
  final Color textColor;

  /// Ikon yang akan ditampilkan di sebelah teks tombol.
  final Widget icon;

  /// Konstruktor untuk inisialisasi parameter tombol.
  const SocialSignButton({
    required this.onPressed,
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// Membuat tombol memenuhi seluruh lebar parent.
      width: double.infinity,
      child: ElevatedButton.icon(
        /// Memanggil fungsi `onPressed` saat tombol ditekan.
        onPressed: onPressed,

        /// Ikon yang ditampilkan sebelum teks dalam tombol.
        icon: icon,

        /// Label teks pada tombol.
        label: Text(
          text,
          style: TextStyle(
            color: textColor, // Warna teks yang ditentukan dari parameter.
          ),
        ),

        /// Mengatur gaya tombol menggunakan `ElevatedButton.styleFrom`.
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              vertical:
                  16), // Memberikan padding atas & bawah agar tombol lebih besar.
          backgroundColor: backgroundColor, // Warna latar belakang tombol.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10), // Membuat sudut tombol lebih membulat.
          ),
        ),
      ),
    );
  }
}
