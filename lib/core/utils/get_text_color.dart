import 'package:flutter/material.dart';

/// Fungsi `getTextColor` digunakan untuk menentukan warna teks berdasarkan tema aplikasi (terang atau gelap).
///
/// Fungsi ini mengambil konteks `BuildContext` dan memeriksa apakah aplikasi sedang dalam mode terang atau gelap.
/// Jika mode gelap, warna teks yang digunakan adalah `onPrimary` dari `colorScheme`.
/// Jika mode terang, warna teks yang digunakan adalah `primary` dari `colorScheme`.
///
/// - **Parameter**:
///   - `context` (`BuildContext`): Konteks widget yang digunakan untuk mendapatkan tema aplikasi.
///
/// - **Return**:
///   - `Color`: Warna yang akan digunakan untuk teks berdasarkan mode terang atau gelap.
Color getTextColor(BuildContext context) {
  /// Mendapatkan `colorScheme` dari tema saat ini.
  final colorScheme = Theme.of(context).colorScheme;

  /// Mengecek apakah aplikasi dalam mode gelap.
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  /// Jika mode gelap, gunakan warna `onPrimary` dari `colorScheme`.
  /// Jika mode terang, gunakan warna `primary` dari `colorScheme`.
  return isDarkMode ? colorScheme.onPrimary : colorScheme.primary;
}
