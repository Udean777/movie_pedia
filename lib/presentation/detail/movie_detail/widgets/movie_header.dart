import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';

/// Widget `MovieHeader` menampilkan gambar latar belakang film, judul, rating, dan tombol wishlist.
/// Menggunakan `ConsumerWidget` untuk membaca state dari Riverpod.
class MovieHeader extends ConsumerWidget {
  /// Model yang berisi detail film.
  final MovieDetailModel movie;

  /// Konstruktor menerima objek `MovieDetailModel` sebagai parameter wajib.
  const MovieHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mendapatkan daftar film yang ada di wishlist.
    final wishlist = ref.watch(wishlistProvider);

    // Mengecek apakah film ini sudah ada di wishlist dengan mencocokkan judul.
    final isWishlisted = wishlist.any((m) => m.title == movie.title);

    // Mendapatkan skema warna dari tema aplikasi.
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Menampilkan gambar latar belakang film.
        Image.network(
          movie.backdropPath,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),

        // Overlay gradasi untuk memberikan efek gelap di bagian bawah.
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF1F1D2B),
              ],
            ),
          ),
        ),

        // Posisi elemen informasi film di bagian bawah gambar.
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Menampilkan poster film dengan border radius.
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterPath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 16),

              // Menampilkan judul film dan rating.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),

                    // Menampilkan rating film dengan ikon bintang.
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Tombol kembali di pojok kiri atas.
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        // Tombol wishlist di pojok kanan atas.
        Positioned(
          top: 40,
          right: 16,
          child: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: isWishlisted ? Colors.red : Colors.white,
              ),
            ),
            onPressed: () {
              // Mengakses provider wishlist untuk menambahkan atau menghapus film dari daftar wishlist.
              final wishlistNotifier = ref.read(wishlistProvider.notifier);

              if (isWishlisted) {
                wishlistNotifier.removeFromWishlist(movie.title);
              } else {
                wishlistNotifier.addToWishlist(movie);
              }
            },
          ),
        ),
      ],
    );
  }
}
