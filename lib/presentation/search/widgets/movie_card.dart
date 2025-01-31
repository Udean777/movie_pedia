import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/presentation/search/widgets/movie_genres.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final ColorScheme colorScheme;

  const MovieCard({
    required this.movie,
    required this.colorScheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: colorScheme.primary,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
