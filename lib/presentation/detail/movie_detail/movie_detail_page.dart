import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/movie_detail_widget.dart';

/// Widget untuk menampilkan halaman detail film.
/// Menggunakan Riverpod untuk mendapatkan data film dari TMDB API.
class MovieDetailPage extends ConsumerWidget {
  /// ID film yang akan ditampilkan detailnya.
  final int movieId;

  /// Constructor menerima `movieId` yang digunakan untuk memuat data film.
  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Menggunakan provider untuk mendapatkan data detail film berdasarkan movieId
    final movieDetail = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      body: movieDetail.when(
        // Jika data berhasil dimuat, tampilkan widget detail film
        data: (movie) => MovieDetailWidget(
          movie: movie,
        ),
        // Jika masih dalam proses loading, tampilkan indikator loading
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        // Jika terjadi error saat memuat data, tampilkan pesan kesalahan
        error: (error, _) => const Center(
          child: Text("Failed to load details"),
        ),
      ),
    );
  }
}
