import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/genre_model.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

class MovieGenres extends ConsumerWidget {
  final MovieModel movie;

  const MovieGenres({required this.movie, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresAsync = ref.watch(genresProvider.future);

    return FutureBuilder<List<GenreModel>>(
      future: genresAsync,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const NotFound(
            image: 'assets/video-player.png',
            title: 'Sorry no movies found with that name',
          );
        }

        final genres = snapshot.data!
            .where((genre) => movie.genreIds.contains(genre.id))
            .map((genre) => genre.name)
            .join(', ');

        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const Icon(
                Icons.movie,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  genres.isEmpty ? 'Unknown' : genres,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
