import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/movie_detail_page.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

/// `MovieHomeCard` adalah widget yang menampilkan kartu informasi film dalam aplikasi.
/// Widget ini menggunakan Riverpod untuk manajemen state dan menampilkan:
/// - Poster film
/// - Tombol favorit (opsional)
/// - Tombol wishlist (opsional)
/// - Informasi judul dan rating film
class MovieHomeCard extends ConsumerWidget {
  /// Membuat instance baru dari MovieHomeCard
  ///
  /// Parameters:
  /// - [movie] : Model data film yang akan ditampilkan
  /// - [isFavorite] : Status apakah film ada di daftar favorit
  /// - [isWishlisted] : Status apakah film ada di wishlist
  /// - [colorScheme] : Skema warna yang digunakan untuk styling
  /// - [showFavoriteIcon] : Menentukan apakah ikon favorit ditampilkan (default: true)
  /// - [showWishlistIcon] : Menentukan apakah ikon wishlist ditampilkan (default: true)
  const MovieHomeCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.isWishlisted,
    required this.colorScheme,
    this.showFavoriteIcon = true,
    this.showWishlistIcon = true,
  });

  /// Data model film yang akan ditampilkan
  final MovieModel movie;

  /// Status favorit dari film
  final bool isFavorite;

  /// Status wishlist dari film
  final bool isWishlisted;

  /// Skema warna untuk styling komponen
  final ColorScheme colorScheme;

  /// Flag untuk menampilkan/menyembunyikan ikon favorit
  final bool showFavoriteIcon;

  /// Flag untuk menampilkan/menyembunyikan ikon wishlist
  final bool showWishlistIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      /// Menangani tap pada kartu untuk navigasi ke halaman detail
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movieId: movie.id),
          ),
        );
      },
      child: ClipRRect(
        /// Memberikan efek rounded corner pada kartu
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            /// Widget untuk menampilkan poster film
            /// Menggunakan Image.network untuk memuat gambar dari URL
            Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            /// Tombol Favorit
            /// Hanya ditampilkan jika showFavoriteIcon == true
            if (showFavoriteIcon)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  /// Styling container untuk tombol favorit
                  /// Menggunakan background semi-transparan
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    /// Menggunakan icon yang berbeda berdasarkan status favorit
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 20,
                    ),

                    /// Handler untuk menambah/menghapus dari daftar favorit
                    onPressed: () async {
                      if (isFavorite) {
                        await ref
                            .read(favoriteProvider.notifier)
                            .removeFromFavorite(movie.title);
                      } else {
                        final movieDetail = await ref
                            .read(movieDetailProvider(movie.id).future);
                        await ref
                            .read(favoriteProvider.notifier)
                            .addToFavorite(movieDetail);
                      }
                    },
                  ),
                ),
              ),

            /// Tombol Wishlist
            /// Hanya ditampilkan jika showWishlistIcon == true
            if (showWishlistIcon)
              Positioned(
                top: 60,
                right: 8,
                child: Container(
                  /// Styling container untuk tombol wishlist
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    /// Menggunakan icon yang berbeda berdasarkan status wishlist
                    icon: Icon(
                      isWishlisted ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                    ),

                    /// Handler untuk menambah/menghapus dari wishlist
                    onPressed: () async {
                      if (isWishlisted) {
                        ref
                            .read(wishlistProvider.notifier)
                            .removeFromWishlist(movie.title);
                      } else {
                        final movieDetail = await ref
                            .read(movieDetailProvider(movie.id).future);
                        ref
                            .read(wishlistProvider.notifier)
                            .addToWishlist(movieDetail);
                      }
                    },
                  ),
                ),
              ),

            /// Overlay informasi film
            /// Menampilkan judul dan rating di bagian bawah kartu
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),

                /// Memberikan efek gradasi pada background overlay
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Widget judul film
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// Widget rating film
                    Text(
                      '⭐ ${movie.voteAverage}',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
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
