import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<WishlistMovie>>((ref) {
  final user = ref.watch(authStateNotifierProvider).value;
  return WishlistNotifier(userId: user?.uid);
});

final wishlistCountProvider = Provider<AsyncValue<int>>((ref) {
  final wishlistState = ref.watch(wishlistProvider);
  return AsyncValue.data(wishlistState.length);
});

class WishlistMovie {
  final String id;
  final String userId;
  final String title;
  final String posterPath;
  final double voteAverage;
  final List<int> genreIds;
  final int? runtime;

  WishlistMovie({
    required this.id,
    required this.userId,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    this.runtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
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
      userId: data['userId'] ?? '',
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
  final String? userId; // Add userId field

  WishlistNotifier({this.userId}) : super([]) {
    if (userId != null) {
      loadWishlist();
    }
  }

  Future<void> loadWishlist() async {
    if (userId == null) return;

    final snapshot = await _firestore
        .collection('wishlist')
        .where('userId', isEqualTo: userId)
        .get();

    state = snapshot.docs
        .map((doc) => WishlistMovie.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<int?> getWishlistCount() async {
    if (userId == null) return 0;

    final snapshot = await _firestore
        .collection('wishlist')
        .where('userId', isEqualTo: userId)
        .count()
        .get();

    return snapshot.count;
  }

  Future<void> addToWishlist(MovieDetailModel movieDetail) async {
    if (userId == null) return;

    final exists = state.any((m) => m.title == movieDetail.title);
    if (!exists) {
      final docRef = await _firestore.collection('wishlist').add({
        'userId': userId,
        'title': movieDetail.title,
        'posterPath': movieDetail.posterPath,
        'voteAverage': movieDetail.voteAverage,
        'genreIds': movieDetail.genres.map((g) => g.id.toString()).join(','),
        'runtime': movieDetail.runtime,
      });

      final newMovie = WishlistMovie(
        id: docRef.id,
        userId: userId!,
        title: movieDetail.title,
        posterPath: movieDetail.posterPath,
        voteAverage: movieDetail.voteAverage,
        genreIds: movieDetail.genres.map((g) => g.id).toList(),
        runtime: movieDetail.runtime,
      );

      state = [...state, newMovie];
    }
  }

  Future<void> removeFromWishlist(String title) async {
    if (userId == null) return;

    final movie = state.firstWhere(
      (m) => m.title == title,
      orElse: () => WishlistMovie(
        id: '',
        userId: '',
        title: '',
        posterPath: '',
        voteAverage: 0.0,
        genreIds: [],
      ),
    );

    if (movie.id.isNotEmpty) {
      await _firestore.collection('wishlist').doc(movie.id).delete();
      state = state.where((m) => m.id != movie.id).toList();
    }
  }
}
