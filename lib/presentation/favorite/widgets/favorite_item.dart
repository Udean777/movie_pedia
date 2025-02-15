import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/favorite_movie.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

/// **FavoriteItem Widget**
///
/// Widget ini menampilkan satu film dalam daftar favorit pengguna.
/// Film ditampilkan dengan poster, judul, rating, durasi, dan genre.
/// Pengguna juga bisa menghapus film dari daftar favorit dengan swipe ke kiri.
///
/// **Parameter:**
/// - `movie` (FavoriteMovie): Objek film yang akan ditampilkan.
///
/// **Fitur Utama:**
/// - Menampilkan informasi film seperti poster, judul, rating, runtime, dan genre.
/// - Bisa dihapus dari favorit dengan geser ke kiri.
/// - Menggunakan `ConsumerWidget` untuk membaca dan memperbarui state dari Riverpod.
class FavoriteItem extends ConsumerWidget {
  /// Objek film yang ditampilkan dalam daftar favorit.
  final FavoriteMovie movie;

  /// Konstruktor untuk inisialisasi `FavoriteItem`.
  const FavoriteItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Mengambil skema warna dari tema aplikasi.
    final colorScheme = Theme.of(context).colorScheme;

    /// Notifier untuk mengelola daftar favorit.
    final favoriteNotifier = ref.read(favoriteProvider.notifier);

    /// Mendapatkan daftar genre berdasarkan `genreIds` film dari provider TMDB.
    final genres = ref.watch(genresProvider).when(
          /// Jika data berhasil diambil, filter genre berdasarkan `genreIds` film.
          data: (genreList) => genreList
              .where((genre) => movie.genreIds.contains(genre.id))
              .map((genre) => genre.name)
              .join(', '),

          /// Jika masih memuat data genre, tampilkan teks "Loading...".
          loading: () => 'Loading...',

          /// Jika terjadi kesalahan dalam mengambil data genre, tampilkan "Unknown".
          error: (_, __) => 'Unknown',
        );

    return Dismissible(
      /// Gunakan judul film sebagai kunci unik untuk widget ini.
      key: Key(movie.title),

      /// Mengatur swipe hanya bisa dilakukan dari kanan ke kiri.
      direction: DismissDirection.endToStart,

      /// Fungsi yang dijalankan saat film dihapus dari daftar favorit.
      onDismissed: (direction) =>
          favoriteNotifier.removeFromFavorite(movie.title),

      /// Latar belakang merah dengan ikon tempat sampah saat di-swipe.
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red, // Warna merah untuk indikasi penghapusan.
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      /// Card untuk menampilkan informasi film dalam daftar favorit.
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Menampilkan poster film dengan sudut melengkung.
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                /// Gunakan poster dari TMDB jika tersedia, jika tidak gunakan placeholder.
                movie.posterPath.isNotEmpty
                    ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                    : 'https://via.assets.so/img.jpg?w=400&h=450&tc=blue&bg=#cecece',
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),

            /// Bagian teks berisi informasi film.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Menampilkan judul film dengan teks bold.
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
