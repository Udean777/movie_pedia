import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/database/wishlist_db.dart';

final wishlistDatabaseProvider = Provider<WishlistDb>((ref) => WishlistDb());

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<WishlistMovie>>((ref) {
  final db = ref.watch(wishlistDatabaseProvider);
  return WishlistNotifier(db);
});

class WishlistNotifier extends StateNotifier<List<WishlistMovie>> {
  final WishlistDb _wishlistDb;

  WishlistNotifier(this._wishlistDb) : super([]) {
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    state = await _wishlistDb.getWishlist();
  }

  Future<void> addToWishlist(WishlistMovie movie) async {
    final exists = await _wishlistDb.isMovieInWishlist(movie.title);
    if (!exists) {
      await _wishlistDb.addToWishlist(WishlistMoviesCompanion.insert(
        title: movie.title,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage,
      ));
      state = [...state, movie]; // Update state langsung agar lebih responsif
    }
  }

  Future<void> removeFromWishlist(String title) async {
    await _wishlistDb.removeFromWishlistByTitle(title);
    state =
        state.where((m) => m.title != title).toList(); // Update state langsung
  }
}
