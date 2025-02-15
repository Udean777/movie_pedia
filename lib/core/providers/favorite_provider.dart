import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/favorite_movie.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';

/// Provider untuk mengelola state favorite menggunakan StateNotifier.
/// Memantau perubahan autentikasi pengguna dan memuat favorite pengguna berdasarkan userId.
final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, List<FavoriteMovie>>((ref) {
  final user = ref.watch(authStateNotifierProvider).value;
  return FavoriteNotifier(userId: user?.uid);
});

/// Provider untuk menghitung jumlah film dalam favorite.
/// Memantau perubahan pada [favoriteProvider] dan mengembalikan jumlah item dalam favorite.
final favoriteCountProvider = Provider<AsyncValue<int>>((ref) {
  final favoritetState = ref.watch(favoriteProvider);
  return AsyncValue.data(favoritetState.length);
});

/// StateNotifier untuk mengelola favorite film pengguna.
class FavoriteNotifier extends StateNotifier<List<FavoriteMovie>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId; // User ID untuk membedakan favorite setiap pengguna

  /// Konstruktor FavoriteNotifier.
  /// Jika userId tidak null, akan langsung memuat data favorite pengguna dari Firestore.
  FavoriteNotifier({this.userId}) : super([]) {
    if (userId != null) {
      loadFavorite();
    }
  }

  /// Memuat daftar favorite dari Firestore berdasarkan userId.
  Future<void> loadFavorite() async {
    if (userId == null) return;

    final snapshot = await _firestore
        .collection('favorite')
        .where('userId', isEqualTo: userId)
        .get();

    state = snapshot.docs
        .map((doc) => FavoriteMovie.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// Mengambil jumlah film dalam favorite dari Firestore.
  Future<int?> getFavoriteCount() async {
    if (userId == null) return 0;

    final snapshot = await _firestore
        .collection('favorite')
        .where('userId', isEqualTo: userId)
        .count()
        .get();

    return snapshot.count;
  }

  /// Menambahkan film ke favorite jika belum ada.
  /// Mencegah duplikasi dengan mengecek apakah film dengan judul yang sama sudah ada.
  Future<void> addToFavorite(MovieDetailModel movieDetail) async {
    if (userId == null) return;

    // Cek apakah film sudah ada di favorite berdasarkan judul
    final exists = state.any((m) => m.title == movieDetail.title);
    if (!exists) {
      // Menambahkan data ke Firestore
      final docRef = await _firestore.collection('favorite').add({
        'userId': userId,
        'title': movieDetail.title,
        'posterPath': movieDetail.posterPath,
        'voteAverage': movieDetail.voteAverage,
        'genreIds': movieDetail.genres.map((g) => g.id.toString()).join(','),
        'runtime': movieDetail.runtime,
      });

      // Membuat objek FavoriteMovie untuk diperbarui di state
      final newMovie = FavoriteMovie(
        id: docRef.id,
        userId: userId!,
        title: movieDetail.title,
        posterPath: movieDetail.posterPath,
        voteAverage: movieDetail.voteAverage,
        genreIds: movieDetail.genres.map((g) => g.id).toList(),
        runtime: movieDetail.runtime,
      );

      // Memperbarui state dengan menambahkan film baru ke dalam daftar favorite
      state = [...state, newMovie];
    }
  }

  /// Menghapus film dari favorite berdasarkan judul.
  Future<void> removeFromFavorite(String title) async {
    if (userId == null) return;

    // Mencari film berdasarkan judul dalam state
    final movie = state.firstWhere(
      (m) => m.title == title,
      orElse: () => FavoriteMovie(
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
      await _firestore.collection('favorite').doc(movie.id).delete();
      state = state.where((m) => m.id != movie.id).toList();
    }
  }
}
