import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/database/wishlist_db.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';

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

  Future<void> addToWishlistFromDetail(MovieDetailModel movieDetail) async {
    final exists = await _wishlistDb.isMovieInWishlist(movieDetail.title);
    if (!exists) {
      final wishlistMovie = WishlistMovieExtension.fromMovieDetail(movieDetail);
      await _wishlistDb.addToWishlist(wishlistMovie);

      final newMovie = WishlistMovie(
        id: 0,
        title: movieDetail.title,
        posterPath: movieDetail.posterPath,
        voteAverage: double.parse(movieDetail.voteAverage.toString()),
        genreIds: movieDetail.genres.join(','),
        runtime: movieDetail.runtime,
      );

      state = [...state, newMovie];
    }
  }

  Future<void> removeFromWishlist(String title) async {
    await _wishlistDb.removeFromWishlistByTitle(title);
    state = state.where((m) => m.title != title).toList();
  }
}
