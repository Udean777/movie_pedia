import 'package:flutter/material.dart';

/// **CustomButton** adalah tombol kustom yang dapat menampilkan teks atau indikator loading.
///
/// Tombol ini mendukung dua mode:
/// - **Normal**: Menampilkan teks tombol.
/// - **Loading**: Menampilkan `CircularProgressIndicator` jika sedang dalam proses.
///
/// **Parameter:**
/// - `isLoading`: (boolean) Menentukan apakah tombol sedang dalam proses atau tidak.
/// - `onPressed`: (VoidCallback) Fungsi yang akan dijalankan saat tombol ditekan.
/// - `text`: (String) Teks yang akan ditampilkan pada tombol.
///
/// **Fitur Utama:**
/// - Menggunakan `ElevatedButton` dengan gaya kustom.
/// - Saat `isLoading` bernilai `true`, tombol dinonaktifkan (`onPressed: null`).
/// - `CircularProgressIndicator` digunakan sebagai indikator loading.
/// - Warna tombol dan teks mengikuti `Theme.of(context).colorScheme`.
///
/// **Penggunaan:**
/// ```dart
/// CustomButton(
///   isLoading: false,
///   onPressed: () {
///     print("Button Pressed");
///   },
///   text: "Submit",
/// )
/// ```
class CustomButton extends StatelessWidget {
  /// Menentukan apakah tombol sedang dalam mode loading atau tidak.
  final bool isLoading;

  /// Callback yang akan dipanggil saat tombol ditekan.
  final VoidCallback onPressed;

  /// Teks yang ditampilkan di dalam tombol.
  final String text;

  /// Konstruktor untuk `CustomButton`.
  const CustomButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// Menjadikan tombol memenuhi lebar maksimum yang tersedia.
      width: double.infinity,
      child: ElevatedButton(
        /// Jika tombol dalam mode loading, `onPressed` diatur ke `null` agar tombol dinonaktifkan.
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          /// Menambahkan padding vertikal pada tombol agar lebih besar.
          padding: const EdgeInsets.symmetric(vertical: 16),

          /// Warna latar belakang tombol mengikuti tema utama aplikasi.
          backgroundColor: Theme.of(context).colorScheme.primary,

          /// Bentuk tombol dengan sudut melengkung (border radius).
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        /// Menentukan isi tombol berdasarkan status `isLoading`.
        child: isLoading
            ? const CircularProgressIndicator(
                /// Mengatur warna loading spinner agar selalu berwarna putih.
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,

                  /// Warna teks tombol mengikuti warna yang disesuaikan dengan tema.
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }
}
