import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/models/wishlist_movie.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';

/// Provider untuk mengelola state wishlist menggunakan StateNotifier.
/// Memantau perubahan autentikasi pengguna dan memuat wishlist pengguna berdasarkan userId.
final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<WishlistMovie>>((ref) {
  final user = ref.watch(authStateNotifierProvider).value;
  return WishlistNotifier(userId: user?.uid);
});

/// Provider untuk menghitung jumlah film dalam wishlist.
/// Memantau perubahan pada [wishlistProvider] dan mengembalikan jumlah item dalam wishlist.
final wishlistCountProvider = Provider<AsyncValue<int>>((ref) {
  final wishlistState = ref.watch(wishlistProvider);
  return AsyncValue.data(wishlistState.length);
});

/// StateNotifier untuk mengelola wishlist film pengguna.
class WishlistNotifier extends StateNotifier<List<WishlistMovie>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId; // User ID untuk membedakan wishlist setiap pengguna

  /// Konstruktor WishlistNotifier.
  /// Jika userId tidak null, akan langsung memuat data wishlist pengguna dari Firestore.
  WishlistNotifier({this.userId}) : super([]) {
    if (userId != null) {
      loadWishlist();
    }
  }

  /// Memuat daftar wishlist dari Firestore berdasarkan userId.
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

  /// Mengambil jumlah film dalam wishlist dari Firestore.
  Future<int?> getWishlistCount() async {
    if (userId == null) return 0;

    final snapshot = await _firestore
        .collection('wishlist')
        .where('userId', isEqualTo: userId)
        .count()
        .get();

    return snapshot.count;
  }

  /// Menambahkan film ke wishlist jika belum ada.
  /// Mencegah duplikasi dengan mengecek apakah film dengan judul yang sama sudah ada.
  Future<void> addToWishlist(MovieDetailModel movieDetail) async {
    if (userId == null) return;

    // Cek apakah film sudah ada di wishlist berdasarkan judul
    final exists = state.any((m) => m.title == movieDetail.title);
    if (!exists) {
      // Menambahkan data ke Firestore
      final docRef = await _firestore.collection('wishlist').add({
        'userId': userId,
        'title': movieDetail.title,
        'posterPath': movieDetail.posterPath,
        'voteAverage': movieDetail.voteAverage,
        'genreIds': movieDetail.genres.map((g) => g.id.toString()).join(','),
        'runtime': movieDetail.runtime,
      });

      // Membuat objek WishlistMovie untuk diperbarui di state
      final newMovie = WishlistMovie(
        id: docRef.id,
        userId: userId!,
        title: movieDetail.title,
        posterPath: movieDetail.posterPath,
        voteAverage: movieDetail.voteAverage,
        genreIds: movieDetail.genres.map((g) => g.id).toList(),
        runtime: movieDetail.runtime,
      );

      // Memperbarui state dengan menambahkan film baru ke dalam daftar wishlist
      state = [...state, newMovie];
    }
  }

  /// Menghapus film dari wishlist berdasarkan judul.
  Future<void> removeFromWishlist(String title) async {
    if (userId == null) return;

    // Mencari film berdasarkan judul dalam state
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

    // Jika film ditemukan, hapus dari Firestore dan perbarui state
    if (movie.id.isNotEmpty) {
      await _firestore.collection('wishlist').doc(movie.id).delete();
      state = state.where((m) => m.id != movie.id).toList();
    }
  }
}
