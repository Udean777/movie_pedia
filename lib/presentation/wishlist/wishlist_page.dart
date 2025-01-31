import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: wishlist.isEmpty
          ? NotFound(
              image: 'assets/popcorn.png',
              title: 'Wishlist is empty',
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final movie = wishlist[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(
                    movie.voteAverage.toStringAsFixed(1).toString(),
                  ),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(wishlistProvider.notifier)
                          .removeFromWishlist(movie.title);
                    },
                  ),
                );
              },
            ),
    );
  }
}
