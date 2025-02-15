import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/movie_header.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/movie_info.dart';

/// Widget utama untuk menampilkan detail film.
///
/// `MovieDetailWidget` terdiri dari dua bagian utama:
/// - `MovieHeader`: Menampilkan gambar latar belakang, poster, judul film, rating, dan tombol wishlist.
/// - `MovieInfo`: Menampilkan informasi tambahan seperti durasi, genre, dan tab detail lainnya.
class MovieDetailWidget extends StatelessWidget {
  /// Model detail film yang digunakan untuk menampilkan informasi pada UI.
  final MovieDetailModel movie;

  /// Konstruktor untuk menerima data `movie` yang akan ditampilkan.
  const MovieDetailWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      /// Menggunakan `SingleChildScrollView` agar layar dapat di-scroll jika konten melebihi batas layar.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Menampilkan bagian header film, termasuk gambar utama dan rating.
          MovieHeader(movie: movie),

          /// Menampilkan informasi tambahan tentang film, seperti genre, durasi, dan tab lainnya.
          MovieInfo(movie: movie),
        ],
      ),
    );
  }
}
