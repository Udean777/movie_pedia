import 'package:flutter/material.dart';

/// **CustomTextField** adalah widget input teks kustom berbasis `TextFormField`.
///
/// Widget ini mendukung fitur berikut:
/// - **Mode teks biasa atau password** (dengan `obscureText`).
/// - **Ikon prefix** untuk memberikan indikasi input.
/// - **Gaya warna teks yang bisa disesuaikan**.
/// - **Validasi input sederhana** untuk memastikan input tidak kosong.
/// - **Tampilan dengan `OutlineInputBorder` dan warna latar belakang abu-abu**.
///
/// **Parameter:**
/// - `controller`: (TextEditingController) Kontroler untuk mengelola teks input.
/// - `labelText`: (String) Teks label yang ditampilkan pada input.
/// - `icon`: (IconData) Ikon di sisi kiri input untuk memberikan konteks.
/// - `isPassword`: (boolean, default `false`) Jika `true`, teks akan disembunyikan (untuk input password).
/// - `inputTextColor`: (Color, default `Colors.black`) Warna teks yang dimasukkan pengguna.
///
/// **Contoh Penggunaan:**
/// ```dart
/// CustomTextField(
///   controller: myController,
///   labelText: "Email",
///   icon: Icons.email,
/// )
/// ```
class CustomTextField extends StatelessWidget {
  /// Kontroler untuk mengelola teks yang dimasukkan pengguna.
  final TextEditingController controller;

  /// Label yang akan ditampilkan sebagai placeholder di dalam input.
  final String labelText;

  /// Ikon di sisi kiri input untuk memberikan konteks visual.
  final IconData icon;

  /// Menentukan apakah input digunakan untuk password (dengan teks tersembunyi).
  final bool isPassword;

  /// Warna teks yang dimasukkan pengguna.
  final Color inputTextColor;

  /// Konstruktor untuk `CustomTextField`.
  const CustomTextField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.inputTextColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      /// Menghubungkan `TextFormField` dengan `controller` untuk mengelola input teks.
      controller: controller,

      /// Menentukan tipe keyboard berdasarkan `isPassword`:
      /// - Jika `isPassword == true`, gunakan keyboard teks biasa.
      /// - Jika `isPassword == false`, gunakan keyboard email (karena defaultnya diatur untuk email input).
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,

      /// Jika `isPassword == true`, teks akan disembunyikan.
      obscureText: isPassword,

      /// Gaya teks input sesuai dengan `inputTextColor`.
      style: TextStyle(color: inputTextColor),

      /// Dekorasi tampilan input.
      decoration: InputDecoration(
        /// Label teks di dalam input field.
        labelText: labelText,

        /// Ikon di bagian kiri input untuk memberikan indikasi jenis input.
        prefixIcon: Icon(icon),

        /// Mengaktifkan warna latar belakang input.
        filled: true,

        /// Warna latar belakang input (abu-abu muda).
        fillColor: Colors.grey[200],

        /// Gaya label teks agar terlihat lebih halus dengan warna abu-abu.
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),

        /// Membuat border dengan sudut melengkung dan tanpa garis.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),

      /// Validasi input agar tidak boleh kosong.
      validator: (value) =>
          value!.isEmpty ? '$labelText cannot be empty' : null,
    );
  }
}
