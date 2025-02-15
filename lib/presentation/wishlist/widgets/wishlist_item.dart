import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/wishlist_movie.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';

/// **WishlistItem Widget**
///
/// Widget ini digunakan untuk menampilkan sebuah film dalam daftar wishlist pengguna.
/// Film yang ditampilkan memiliki informasi seperti poster, judul, rating, durasi, dan genre.
/// Selain itu, pengguna dapat menghapus film dari wishlist dengan menggesernya ke kiri.
///
/// **Parameter:**
/// - `movie` (WishlistMovie): Objek film yang akan ditampilkan dalam wishlist.
///
/// **Fitur Utama:**
/// - Menampilkan informasi film, termasuk poster, judul, rating, runtime, dan genre.
/// - Dapat dihapus dari wishlist dengan menggeser (swipe) ke kiri.
/// - Menggunakan `ConsumerWidget` agar dapat membaca dan memperbarui state dari Riverpod.

class WishlistItem extends ConsumerWidget {
  /// Objek film yang ditampilkan dalam wishlist.
  final WishlistMovie movie;

  /// Konstruktor untuk inisialisasi `WishlistItem`.
  const WishlistItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Mengambil skema warna dari tema aplikasi.
    final colorScheme = Theme.of(context).colorScheme;

    /// Notifier dari wishlist untuk menghapus film dari daftar.
    final wishlistNotifier = ref.read(wishlistProvider.notifier);

    /// Mendapatkan daftar genre berdasarkan `genreIds` film dari provider TMDB.
    final genres = ref.watch(genresProvider).when(
          /// Jika data berhasil diambil, filter genre berdasarkan `genreIds` film.
          data: (genreList) => genreList
              .where((genre) => movie.genreIds.contains(genre.id))
              .map((genre) => genre.name)
              .join(', '),

          /// Jika sedang memuat data genre, tampilkan teks "Loading...".
          loading: () => 'Loading...',

          /// Jika terjadi kesalahan saat mengambil genre, tampilkan "Unknown".
          error: (_, __) => 'Unknown',
        );

    return Dismissible(
      /// Gunakan judul film sebagai kunci unik untuk widget ini.
      key: Key(movie.title),

      /// Tentukan arah geser untuk menghapus, yaitu dari kanan ke kiri.
      direction: DismissDirection.endToStart,

      /// Fungsi yang dipanggil saat film dihapus dengan swipe.
      onDismissed: (direction) =>
          wishlistNotifier.removeFromWishlist(movie.title),

      /// Widget latar belakang saat item di-swipe, menunjukkan ikon tempat sampah.
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red, // Warna merah untuk indikasi penghapusan.
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      /// Card untuk menampilkan informasi film.
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Menampilkan poster film dalam bentuk gambar dengan sudut melengkung.
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                /// Gunakan poster dari TMDB jika tersedia, jika tidak tampilkan placeholder.
                movie.posterPath.isNotEmpty
                    ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                    : 'https://via.assets.so/img.jpg?w=400&h=450&tc=blue&bg=#cecece',
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),

            /// Bagian teks yang berisi informasi film.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Menampilkan judul film dengan gaya tebal.
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // Hindari teks terlalu panjang.
                    ),
                    const SizedBox(height: 8),

                    /// Menampilkan rating film dengan ikon bintang.
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(
                          ' ${movie.voteAverage.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    /// Menampilkan runtime (durasi film) jika tersedia.
                    if (movie.runtime != null)
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              color: colorScheme.onPrimary, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${movie.runtime ?? 'N/A'} min',
                            style: TextStyle(color: colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),

                    /// Menampilkan genre film berdasarkan `genreIds`.
                    Row(
                      children: [
                        Icon(Icons.movie,
                            color: colorScheme.onPrimary, size: 18),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            genres, // Menampilkan daftar genre film.
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
