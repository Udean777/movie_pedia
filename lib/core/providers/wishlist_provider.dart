import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<WishlistMovie>>((ref) {
  return WishlistNotifier();
});

class WishlistMovie {
  final String id;
  final String title;
  final String posterPath;
  final double voteAverage;
  final List<int> genreIds;
  final int? runtime;

  WishlistMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    this.runtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'genreIds': genreIds.map((e) => e.toString()).join(','),
      'runtime': runtime,
    };
  }

  static WishlistMovie fromMap(String id, Map<String, dynamic> data) {
    return WishlistMovie(
      id: id,
      title: data['title'],
      posterPath: data['posterPath'],
      voteAverage: (data['voteAverage']).toDouble(),
      genreIds: data['genreIds'] != null
          ? List<int>.from(data['genreIds'].split(',').map((e) => int.parse(e)))
          : [],
      runtime: data['runtime'],
    );
  }
}

class WishlistNotifier extends StateNotifier<List<WishlistMovie>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  WishlistNotifier() : super([]) {
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    final snapshot = await _firestore.collection('wishlist').get();
    state = snapshot.docs
        .map((doc) => WishlistMovie.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> addToWishlist(MovieDetailModel movieDetail) async {
    final exists = state.any((m) => m.title == movieDetail.title);
    if (!exists) {
      final docRef = await _firestore.collection('wishlist').add({
        'title': movieDetail.title,
        'posterPath': movieDetail.posterPath,
        'voteAverage': movieDetail.voteAverage,
        'genreIds': movieDetail.genres.map((g) => g.id.toString()).join(','),
        'runtime': movieDetail.runtime,
      });
      state = [...state, WishlistMovie.fromMap(docRef.id, movieDetail.toMap())];
    }
  }

  Future<void> removeFromWishlist(String title) async {
    final movie = state.firstWhere((m) => m.title == title,
        orElse: () => WishlistMovie(
            id: '', title: '', posterPath: '', voteAverage: 0.0, genreIds: []));
    if (movie.id.isNotEmpty) {
      await _firestore.collection('wishlist').doc(movie.id).delete();
      state = state.where((m) => m.id != movie.id).toList();
    }
  }
}
