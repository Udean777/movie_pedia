import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

/// Widget `SearchTextField` digunakan untuk menangani input pencarian film.
/// Menggunakan `ConsumerWidget` dari Riverpod untuk membaca dan mengubah state pencarian.
class SearchTextField extends ConsumerWidget {
  /// Controller untuk mengontrol teks yang dimasukkan oleh pengguna.
  final TextEditingController controller;

  /// Konstruktor `SearchTextField` yang menerima `TextEditingController` sebagai parameter wajib.
  const SearchTextField({required this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      // Menggunakan controller untuk mengelola teks input.
      controller: controller,
      // Memperbarui state `searchQueryProvider` setiap kali teks berubah.
      onChanged: (value) =>
          ref.read(searchQueryProvider.notifier).state = value,
      decoration: InputDecoration(
        // Placeholder untuk memberikan petunjuk kepada pengguna.
        hintText: 'Search movies...',
        // Ikon pencarian di dalam input field.
        prefixIcon: const Icon(Icons.search),
        // Menentukan gaya border input dengan sudut melengkung.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
