import 'package:flutter/material.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/presentation/wishlist/widgets/wishlist_item.dart';

class WishlistList extends StatelessWidget {
  final List<WishlistMovie> wishlist;

  const WishlistList({required this.wishlist, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        final movie = wishlist[index];
        return WishlistItem(movie: movie);
      },
    );
  }
}
