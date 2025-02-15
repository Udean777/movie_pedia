import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/wishlist_movie.dart';
import 'package:movie_pedia/presentation/wishlist/widgets/wishlist_item.dart';

/// Widget `WishlistList` bertanggung jawab untuk menampilkan daftar film
/// yang telah ditambahkan ke dalam wishlist pengguna.
///
/// Widget ini menerima daftar film (`wishlist`) sebagai parameter dan
/// menampilkan setiap film menggunakan `WishlistItem`.
class WishlistList extends StatelessWidget {
  /// Daftar film yang disukai pengguna (wishlist).
  final List<WishlistMovie> wishlist;

  /// Constructor untuk `WishlistList` yang menerima daftar film `wishlist`
  /// sebagai parameter yang wajib (`required`).
  const WishlistList({required this.wishlist, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      /// Menentukan jumlah item dalam daftar sesuai dengan panjang `wishlist`.
      itemCount: wishlist.length,

      /// Fungsi `itemBuilder` bertanggung jawab untuk membangun setiap item dalam daftar.
      /// - `context`: BuildContext yang digunakan untuk menentukan tampilan widget.
      /// - `index`: Indeks dari item yang sedang dibuat dalam daftar.
      itemBuilder: (context, index) {
        /// Mengambil data film dari `wishlist` berdasarkan indeks.
        final movie = wishlist[index];

        /// Mengembalikan widget `WishlistItem` yang merepresentasikan satu film dalam wishlist.
        return WishlistItem(movie: movie);
      },
    );
  }
}
