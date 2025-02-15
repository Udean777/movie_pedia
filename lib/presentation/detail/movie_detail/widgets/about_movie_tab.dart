import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/similar_card.dart';

/// Widget `AboutMovieTab` menampilkan deskripsi atau sinopsis film.
/// Jika deskripsi tidak tersedia, akan menampilkan pesan "No overview found".
class AboutMovieTab extends StatelessWidget {
  /// Model detail film yang berisi informasi tentang sinopsis film.
  final MovieDetailModel movie;

  /// Konstruktor menerima data `movie` untuk menampilkan sinopsis film.
  const AboutMovieTab({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // Jika tidak ada sinopsis yang tersedia, tampilkan widget `NotFound`.
    if (movie.overview.isEmpty) {
      return NotFound(
        image:
            'assets/movie.png', // Gambar default saat sinopsis tidak tersedia.
        title: 'No overview found', // Pesan ketika sinopsis tidak ditemukan.
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              movie.overview, // Menampilkan sinopsis film.
              style: TextStyle(
                color: getTextColor(
                    context), // Warna teks disesuaikan dengan tema (terang/gelap).
                height:
                    1.5, // Memberikan jarak antar baris agar lebih mudah dibaca.
              ),
            ),
          ),
          const SizedBox(
              height:
                  8), // Memberikan sedikit jarak sebelum menampilkan SimilarMoviesSection
          SimilarMoviesSection(
              movieId: movie.id), // Menampilkan card similar movies
        ],
      ),
    );
  }
}
