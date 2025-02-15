import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/favorite_movie.dart';
import 'package:movie_pedia/presentation/favorite/widgets/favorite_item.dart';

/// **FavoriteList Widget**
///
/// Widget ini digunakan untuk menampilkan daftar film yang telah ditambahkan
/// ke dalam daftar favorite pengguna.
///
/// **Parameter:**
// ignore: unintended_html_in_doc_comment
/// - `favorite` (List<FavoriteMovie>): Daftar film yang telah disukai oleh pengguna.
///
/// **Fitur Utama:**
/// - Menampilkan daftar film favorite menggunakan `FavoriteItem`.
/// - Menggunakan `ListView.builder` untuk memastikan tampilan lebih efisien.
///
/// Jika daftar favorite kosong, maka daftar akan tetap dibangun tetapi tidak akan
/// menampilkan item apa pun.
class FavoriteList extends StatelessWidget {
  /// Daftar film yang disukai pengguna.
  final List<FavoriteMovie> favorite;

  /// Konstruktor untuk inisialisasi `FavoriteList`.
  const FavoriteList({required this.favorite, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      /// Menentukan jumlah item dalam daftar sesuai dengan panjang `favorite`.
      itemCount: favorite.length,

      /// Membangun setiap item dalam daftar berdasarkan indeks.
      /// - `context`: BuildContext yang digunakan untuk menentukan tampilan widget.
      /// - `index`: Indeks dari item yang sedang dibuat dalam daftar.
      itemBuilder: (context, index) {
        /// Mengambil data film berdasarkan indeks.
        final movie = favorite[index];

        /// Mengembalikan widget `FavoriteItem` untuk menampilkan informasi film.
        return FavoriteItem(movie: movie);
      },
    );
  }
}
