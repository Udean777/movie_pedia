import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';

class MovieHeader extends ConsumerWidget {
  final MovieDetailModel movie;

  const MovieHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final isWishlisted = wishlist.any((m) => m.title == movie.title);
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Image.network(
          movie.backdropPath,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF1F1D2B),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterPath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1).toString(),
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.5),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.5),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: isWishlisted ? Colors.red : Colors.white,
              ),
            ),
            onPressed: () {
              final wishlistNotifier = ref.read(wishlistProvider.notifier);
              if (isWishlisted) {
                wishlistNotifier.removeFromWishlist(movie.title);
              } else {
                wishlistNotifier.addToWishlist(movie);
              }
            },
          ),
        ),
      ],
    );
  }
}
