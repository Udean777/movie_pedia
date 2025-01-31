import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/movie_detail_page.dart';
import 'package:movie_pedia/presentation/search/widgets/movie_card.dart';

class MoviesList extends StatelessWidget {
  final List<MovieModel> movies;

  const MoviesList({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movieId: movie.id),
              ),
            );
          },
          child: MovieCard(movie: movie, colorScheme: colorScheme),
        );
      },
    );
  }
}
