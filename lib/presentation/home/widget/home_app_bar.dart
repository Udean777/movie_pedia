import 'package:flutter/material.dart';

/// `HomeAppBar` adalah AppBar khusus untuk halaman utama aplikasi.
/// Menggunakan `ConsumerWidget` untuk integrasi dengan Riverpod.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Konstruktor `HomeAppBar`
  const HomeAppBar({super.key});

  /// **Membangun tampilan AppBar**
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Movie Pedia', // Judul aplikasi yang ditampilkan di AppBar
        style: TextStyle(fontWeight: FontWeight.bold), // Menjadikan teks bold
      ),
      centerTitle: true, // Menjadikan teks judul berada di tengah AppBar
    );
  }

  /// **Menentukan ukuran preferensi tinggi AppBar**
  /// - `kToolbarHeight` adalah tinggi standar AppBar di Flutter.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
