import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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

  /// Fungsi untuk menyimpan gambar ke galeri
  Future<void> _saveImageToGallery(
      BuildContext context, String imageUrl) async {
    try {
      // Menampilkan loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Download gambar menggunakan Dio
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // Simpan gambar ke galeri
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: "MoviePedia_${movie.title.replaceAll(' ', '_')}",
      );

      // Tutup loading indicator
      Navigator.pop(context);

      // Tampilkan pesan sukses/error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['isSuccess']
                ? 'Gambar berhasil disimpan ke galeri'
                : 'Gagal menyimpan gambar',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      // Tutup loading indicator
      Navigator.pop(context);

      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan saat menyimpan gambar'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Fungsi untuk menampilkan modal preview gambar
  void _showImagePreviewModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header dengan judul film dan tombol close
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Gambar preview
                Flexible(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 3.0,
                    child: Image.network(
                      movie.posterPath,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Tombol save to gallery
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _saveImageToGallery(context, movie.posterPath),
                    icon: const Icon(Icons.save_alt),
                    label: const Text('Save to Gallery'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
      onLongPress: () => _showImagePreviewModal(context),
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
