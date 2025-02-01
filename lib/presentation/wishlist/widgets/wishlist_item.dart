import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';

class WishlistItem extends ConsumerWidget {
  final WishlistMovie movie;

  const WishlistItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final wishlistNotifier = ref.read(wishlistProvider.notifier);
    final genres = ref.watch(genresProvider).when(
          data: (genreList) => genreList
              .where((genre) => movie.genreIds.contains(genre.id))
              .map((genre) => genre.name)
              .join(', '),
          loading: () => 'Loading...',
          error: (_, __) => 'Unknown',
        );

    return Dismissible(
      key: Key(movie.title),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) =>
          wishlistNotifier.removeFromWishlist(movie.title),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                movie.posterPath.isNotEmpty
                    ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
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
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(
                          ' ${movie.voteAverage.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (movie.runtime != null)
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              color: colorScheme.onPrimary, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${movie.runtime ?? 'N/A'} min',
                            style: TextStyle(color: colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.movie,
                            color: colorScheme.onPrimary, size: 18),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            genres,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
