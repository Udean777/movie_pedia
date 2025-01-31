import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/movie_header.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/movie_info.dart';

class MovieDetailWidget extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieDetailWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieHeader(movie: movie),
          MovieInfo(movie: movie),
        ],
      ),
    );
  }
}
