import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/favorite/widgets/favorite_list.dart';

/// Halaman `FavoritePage` menampilkan daftar film yang telah ditambahkan
/// ke dalam daftar favorit oleh pengguna.
///
/// Halaman ini menggunakan `ConsumerWidget` karena bergantung pada
/// `favoriteProvider` dari Riverpod untuk mendapatkan dan memperbarui daftar favorit.
class FavoritePage extends ConsumerWidget {
  /// Konstruktor untuk `FavoritePage`.
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Menggunakan `ref.watch` untuk mendapatkan daftar film yang disimpan
    /// sebagai favorit dari `favoriteProvider`.
    final favorite = ref.watch(favoriteProvider);

    /// Fungsi untuk me-refresh daftar favorit dengan memanggil `ref.refresh`.
    ///
    /// Fungsi ini dipanggil ketika pengguna melakukan pull-to-refresh untuk
    /// memperbarui daftar favorit dari sumber data terbaru.
    Future<void> refreshFavorite() async {
      return await ref.refresh(favoriteProvider);
    }

    return Scaffold(
      /// `AppBar` dengan judul "Favorite", ditampilkan di tengah.
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /// `body` menampilkan daftar film favorit atau tampilan kosong jika tidak ada data.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          /// Mengaktifkan fitur pull-to-refresh agar pengguna dapat memperbarui daftar favorit.
          onRefresh: refreshFavorite,

          /// Jika daftar favorit kosong, tampilkan widget `NotFound` dengan gambar dan pesan.
          /// Jika daftar favorit tidak kosong, tampilkan daftar film menggunakan `FavoriteList`.
          child: favorite.isEmpty
              ? const NotFound(
                  image: 'assets/popcorn.png',
                  title: 'Favorite is empty',
                )
              : FavoriteList(
                  favorite: favorite,
                ),
        ),
      ),
    );
  }
}
