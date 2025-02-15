import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/wishlist/widgets/wishlist_list.dart';

/// `WishlistPage` adalah halaman yang menampilkan daftar film yang
/// telah ditambahkan ke dalam wishlist oleh pengguna.
///
/// Halaman ini menggunakan `ConsumerWidget` karena bergantung pada
/// `wishlistProvider` dari Riverpod untuk mendapatkan data wishlist.
class WishlistPage extends ConsumerWidget {
  /// Constructor untuk `WishlistPage`.
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Menggunakan `ref.watch` untuk mendapatkan daftar film yang
    /// telah disimpan dalam wishlist dari `wishlistProvider`.
    final wishlist = ref.watch(wishlistProvider);

    /// Fungsi untuk me-refresh daftar wishlist dengan memanggil `ref.refresh`.
    ///
    /// Fungsi ini dipanggil ketika pengguna melakukan pull-to-refresh.
    Future<void> refreshWishlist() async {
      return await ref.refresh(wishlistProvider);
    }

    return Scaffold(
      /// `AppBar` dengan judul "Wishlist", ditampilkan di tengah.
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /// `body` berisi daftar wishlist atau tampilan kosong jika tidak ada data.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          /// Mengaktifkan fitur pull-to-refresh untuk memperbarui wishlist.
          onRefresh: refreshWishlist,

          /// Jika wishlist kosong, tampilkan `NotFound` dengan gambar dan pesan.
          /// Jika tidak kosong, tampilkan daftar film menggunakan `WishlistList`.
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
