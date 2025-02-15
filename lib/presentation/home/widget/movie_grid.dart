// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/home/widget/movie_home_card.dart';

/// **MovieGrid Widget**
///
/// Widget ini digunakan untuk menampilkan daftar film dalam format grid.
/// `MovieGrid` menggunakan `ConsumerWidget` dari Riverpod untuk membaca dan
/// mengelola state aplikasi.
///
/// **Fitur Utama:**
/// - Mengambil kategori film yang dipilih dari state provider.
/// - Mengambil daftar film dari API berdasarkan kategori.
/// - Menampilkan daftar film dalam bentuk grid dengan 2 kolom.
/// - Menampilkan status apakah film termasuk dalam daftar favorit atau wishlist.
/// - Menampilkan indikator loading saat data sedang dimuat.
/// - Menampilkan pesan error jika terjadi kesalahan saat memuat data.
class MovieGrid extends ConsumerWidget {
  /// Konstruktor untuk `MovieGrid`
  const MovieGrid({super.key});

  /// **Membangun tampilan grid film berdasarkan state Riverpod**
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengambil kategori film yang dipilih dari state provider.
    final selectedCategory = ref.watch(selectedCategoryProvider);

    // Mengambil daftar film berdasarkan kategori yang dipilih.
    final movies = ref.watch(moviesProvider(selectedCategory));

    // Mengambil skema warna dari tema saat ini.
    final colorScheme = Theme.of(context).colorScheme;

    // Mengambil daftar film favorit pengguna.
    final favorites = ref.watch(favoriteProvider);

    return movies.when(
      // **Jika data film berhasil dimuat, tampilkan dalam bentuk grid**
      data: (movies) => GridView.builder(
        padding:
            const EdgeInsets.all(12), // Menambahkan padding di sekitar grid.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Menampilkan 2 kolom dalam grid.
          crossAxisSpacing: 12, // Jarak horizontal antar item dalam grid.
          mainAxisSpacing: 12, // Jarak vertikal antar item dalam grid.
          childAspectRatio:
              0.6, // Rasio aspek item dalam grid (tinggi dibandingkan lebar).
        ),
        itemCount:
            movies.length, // Menentukan jumlah item yang akan ditampilkan.
        itemBuilder: (context, index) {
          final movie = movies[index];

          // **Jika daftar film kosong, tampilkan widget "Not Found"**
          if (movies.isEmpty) {
            return NotFound(
              image: 'assets/video-player.png', // Gambar ikon tidak ada film.
              title: 'No Movies', // Pesan teks yang ditampilkan.
            );
          }

          // **Mengecek apakah film termasuk dalam daftar favorit**
          final isFavorite = favorites.any((m) => m.title == movie.title);

          // **Mengambil daftar film yang ada di wishlist**
          final wishlist = ref.watch(wishlistProvider);

          // **Mengecek apakah film sudah ada di wishlist**
          final isWishlisted = wishlist.any((m) => m.title == movie.title);

          // **Menampilkan widget MovieHomeCard untuk setiap film dalam daftar**
          return MovieHomeCard(
            movie: movie,
            isFavorite: isFavorite,
            isWishlisted: isWishlisted,
            colorScheme: colorScheme,
          );
        },
      ),
      // **Jika masih loading, tampilkan indikator loading**
      loading: () => const Center(child: CircularProgressIndicator()),

      // **Jika terjadi error, tampilkan pesan kesalahan**
      error: (error, _) => Center(
        child: Text(
          "Failed to load movies", // Pesan error yang ditampilkan.
          style: TextStyle(
              color: colorScheme.error), // Warna teks error sesuai tema.
        ),
      ),
    );
  }
}
