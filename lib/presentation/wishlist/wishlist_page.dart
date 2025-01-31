import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/wishlist/widgets/wishlist_list.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    Future<void> refreshWishlist() async {
      return await ref.refresh(wishlistProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: refreshWishlist,
          child: wishlist.isEmpty
              ? NotFound(
                  image: 'assets/popcorn.png',
                  title: 'Wishlist is empty',
                )
              : WishlistList(wishlist: wishlist),
        ),
      ),
    );
  }
}
