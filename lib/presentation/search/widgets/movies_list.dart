import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/movie_detail_page.dart';
import 'package:movie_pedia/presentation/search/widgets/movie_card.dart';

/// Widget `MoviesList` digunakan untuk menampilkan daftar film dalam bentuk `ListView`.
/// Setiap item dalam daftar ditampilkan menggunakan `MovieCard` dan memiliki fitur navigasi
/// untuk menuju ke halaman detail film saat ditekan.
class MoviesList extends StatelessWidget {
  /// Daftar film yang akan ditampilkan.
  final List<MovieModel> movies;

  /// Konstruktor untuk `MoviesList`, menerima daftar film yang harus ditampilkan.
  const MoviesList({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil skema warna dari tema aplikasi.
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      // Menentukan jumlah item dalam daftar berdasarkan panjang list `movies`.
      itemCount: movies.length,
      // `itemBuilder` akan dipanggil untuk setiap indeks dalam daftar `movies`.
      itemBuilder: (context, index) {
        // Mendapatkan data film pada indeks tertentu.
        final movie = movies[index];

        return GestureDetector(
          // Saat item ditekan, navigasikan ke halaman detail film dengan `movieId`.
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movieId: movie.id),
              ),
            );
          },
          // Menampilkan kartu film dengan informasi yang diberikan.
          child: MovieCard(movie: movie, colorScheme: colorScheme),
        );
      },
    );
  }
}
