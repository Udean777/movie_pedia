import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

class CastTab extends StatelessWidget {
  final MovieDetailModel movie;

  const CastTab({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    if (movie.cast.isEmpty) {
      return NotFound(
        image: 'assets/movie.png',
        title: 'No cast found',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(top: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: movie.cast.length,
      itemBuilder: (context, index) {
        final cast = movie.cast[index];
        return Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                cast.profilePath?.isNotEmpty == true
                    ? "https://image.tmdb.org/t/p/w200${cast.profilePath}"
                    : "https://via.placeholder.com/60",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                cast.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
