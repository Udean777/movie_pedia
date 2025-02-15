import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/presentation/search/widgets/movie_genres.dart';

/// **MovieCard Widget**
///
/// Widget ini digunakan untuk menampilkan kartu film dalam daftar pencarian atau rekomendasi.
///
/// **Fitur:**
/// - Menampilkan gambar poster film.
/// - Menampilkan judul film dengan maksimal satu baris.
/// - Menampilkan rating film dengan ikon bintang.
/// - Menampilkan tanggal rilis film.
/// - Menampilkan daftar genre film menggunakan `MovieGenres`.
class MovieCard extends StatelessWidget {
  /// **Model data film** yang berisi informasi seperti judul, poster, rating, dan tanggal rilis.
  final MovieModel movie;

  /// **Skema warna dari tema aplikasi**, digunakan untuk konsistensi tampilan.
  final ColorScheme colorScheme;

  /// **Constructor** untuk `MovieCard`
  /// - `movie` harus diberikan untuk menampilkan informasi film.
  /// - `colorScheme` digunakan untuk menyesuaikan warna latar belakang dan teks.
  const MovieCard({
    required this.movie,
    required this.colorScheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          vertical: 8), // Memberikan jarak antar kartu
      color: colorScheme.primary, // Warna latar belakang kartu
      shadowColor: Colors.transparent, // Menghilangkan shadow pada kartu
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12), // Membuat sudut kartu melengkung
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// **Gambar Poster Film**
          /// - Jika `posterPath` tersedia, gunakan gambar dari URL.
          /// - Jika `posterPath` kosong, gunakan placeholder image default.
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              movie.posterPath.isNotEmpty
                  ? movie.posterPath
                  : 'https://via.assets.so/img.jpg?w=400&h=450&tc=blue&bg=#cecece',
              width: 100,
              height: 150,
              fit: BoxFit.cover, // Memastikan gambar terisi dengan baik
            ),
          ),

          /// **Bagian Informasi Film**
          /// - Menggunakan `Expanded` agar teks tidak keluar dari batas kartu.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Judul Film**
                  /// - Ditampilkan dalam satu baris dengan ellipsis jika terlalu panjang.
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

                  /// **Rating Film**
                  /// - Menampilkan ikon bintang berwarna kuning.
                  /// - Menampilkan rating dari `voteAverage`.
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Text(
                        ' ${movie.voteAverage}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// **Tanggal Rilis Film**
                  /// - Jika tanggal rilis kosong, tampilkan teks `Unknown`.
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        movie.releaseDate.isEmpty
                            ? 'Unknown'
                            : movie.releaseDate,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// **Genre Film**
                  /// - Menggunakan `MovieGenres` untuk menampilkan daftar genre yang sesuai.
                  MovieGenres(movie: movie),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
