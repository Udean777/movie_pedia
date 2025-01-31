import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/movie_detail_page.dart';

class MovieGrid extends StatelessWidget {
  final AsyncValue<List<MovieModel>> movies;
  final ColorScheme colorScheme;

  const MovieGrid({
    required this.movies,
    required this.colorScheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return movies.when(
      data: (movies) => GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.6,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          if (movies.isEmpty) {
            return NotFound(
              image: 'assets/video-player.png',
              title: 'No Movies',
            );
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movie.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
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
                          Text(
                            movie.title,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '⭐ ${movie.voteAverage}',
                            style: TextStyle(
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
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(
          "Failed to load movies",
          style: TextStyle(color: colorScheme.error),
        ),
      ),
    );
  }
}
