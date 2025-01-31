import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/presentation/home/widget/movie_detail_widget.dart';

class MovieDetailPage extends ConsumerWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      body: movieDetail.when(
        data: (movie) => MovieDetailWidget(
          movie: movie,
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) =>
            const Center(child: Text("Failed to load details")),
      ),
    );
  }
}
