import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/presentation/home/widget/movie_home_card.dart';

/// Widget yang menampilkan bagian "Similar Movies" (Film Serupa).
///
/// Menggunakan Riverpod untuk mendapatkan daftar film yang mirip dengan film saat ini,
/// serta status apakah film tersebut ada di daftar favorit atau wishlist pengguna.
class SimilarMoviesSection extends ConsumerWidget {
  /// ID film yang digunakan untuk mendapatkan daftar film serupa.
  final int movieId;

  /// Konstruktor untuk membuat instance `SimilarMoviesSection`.
  const SimilarMoviesSection({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mendapatkan daftar film serupa berdasarkan `movieId`
    final similarMovies = ref.watch(similarMoviesProvider(movieId));

    // Mendapatkan daftar film yang ditandai sebagai favorit oleh pengguna
    final favorites = ref.watch(favoriteProvider);

    // Mendapatkan daftar film yang ditambahkan ke wishlist oleh pengguna
    final wishlist = ref.watch(wishlistProvider);

    return similarMovies.when(
      // Jika data film serupa telah berhasil dimuat
      data: (movies) {
        // Jika tidak ada film serupa, kembalikan widget kosong
        if (movies.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul bagian "Similar Movies"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Similar Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Daftar film serupa dalam bentuk horizontal scroll
            SizedBox(
              height: 200, // Tinggi list film
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Scroll secara horizontal
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  // Periksa apakah film sudah ada di daftar favorit
                  final isFavorite =
                      favorites.any((m) => m.title == movie.title);

                  // Periksa apakah film sudah ada di daftar wishlist
                  final isWishlisted =
                      wishlist.any((m) => m.title == movie.title);

                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SizedBox(
                      width: 130, // Lebar setiap item film dalam daftar
                      child: MovieHomeCard(
                        movie: movie,
                        isFavorite: isFavorite,
                        isWishlisted: isWishlisted,
                        colorScheme: Theme.of(context).colorScheme,
                        showFavoriteIcon:
                            false, // Tidak menampilkan ikon favorit di kartu
                        showWishlistIcon:
                            false, // Tidak menampilkan ikon wishlist di kartu
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      // Jika data sedang dimuat, tampilkan indikator loading
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      // Jika terjadi error, tampilkan pesan kesalahan
      error: (_, __) => const Center(
        child: Text('Failed to load similar movies'),
      ),
    );
  }
}
