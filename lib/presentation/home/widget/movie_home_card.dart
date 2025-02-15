import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/movie_detail_page.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

/// `MovieHomeCard` adalah widget yang menampilkan informasi film dalam bentuk kartu.
/// Kartu ini mencakup gambar poster, tombol favorit, tombol wishlist, dan detail film.
class MovieHomeCard extends ConsumerWidget {
  /// Konstruktor `MovieHomeCard`
  const MovieHomeCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.isWishlisted,
    required this.colorScheme,
  });

  final MovieModel movie;
  final bool isFavorite;
  final bool isWishlisted;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      /// Navigasi ke halaman detail film saat kartu ditekan
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movieId: movie.id),
          ),
        );
      },
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(12), // Membuat sudut kartu melengkung
        child: Stack(
          children: [
            /// Menampilkan gambar poster film
            Image.network(
              movie.posterPath,
              fit: BoxFit.cover, // Menyesuaikan gambar agar pas dalam frame
              width: double.infinity,
              height: double.infinity,
            ),

            /// Tombol Favorite di pojok kanan atas
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                  onPressed: () async {
                    if (isFavorite) {
                      await ref
                          .read(favoriteProvider.notifier)
                          .removeFromFavorite(movie.title);
                    } else {
                      final movieDetail =
                          await ref.read(movieDetailProvider(movie.id).future);
                      await ref
                          .read(favoriteProvider.notifier)
                          .addToFavorite(movieDetail);
                    }
                  },
                ),
              ),
            ),

            /// Tombol Wishlist di bawah tombol Favorite
            Positioned(
              top: 60,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isWishlisted ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (isWishlisted) {
                      ref
                          .read(wishlistProvider.notifier)
                          .removeFromWishlist(movie.title);
                    } else {
                      /// Mengambil detail film sebelum menambahkannya ke wishlist
                      final movieDetail =
                          await ref.read(movieDetailProvider(movie.id).future);
                      ref
                          .read(wishlistProvider.notifier)
                          .addToWishlist(movieDetail);
                    }
                  },
                ),
              ),
            ),

            /// Overlay untuk menampilkan judul dan rating film di bagian bawah kartu
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.all(6), // Padding teks dalam container
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8), // Efek gradasi hitam
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Menampilkan judul film
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Potong teks jika terlalu panjang
                    ),

                    /// Menampilkan rating film
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
