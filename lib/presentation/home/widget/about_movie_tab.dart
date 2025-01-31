import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

class AboutMovieTab extends StatelessWidget {
  final MovieDetailModel movie;

  const AboutMovieTab({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    if (movie.overview.isEmpty) {
      return NotFound(
        image: 'assets/movie.png',
        title: 'No overview found',
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          movie.overview,
          style: const TextStyle(
            color: Colors.black,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
