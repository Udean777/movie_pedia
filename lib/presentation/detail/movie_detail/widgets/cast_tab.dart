import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

/// Widget `CastTab` menampilkan daftar pemeran (cast) dari film dalam bentuk grid.
/// Jika data cast kosong, akan menampilkan pesan "No cast found".
class CastTab extends StatelessWidget {
  /// Model detail film yang berisi daftar cast.
  final MovieDetailModel movie;

  /// Konstruktor menerima data `movie` yang akan digunakan untuk menampilkan daftar cast.
  const CastTab({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // Jika tidak ada cast yang tersedia, tampilkan widget `NotFound`.
    if (movie.cast.isEmpty) {
      return NotFound(
        image: 'assets/movie.png', // Gambar default saat tidak ada cast.
        title: 'No cast found', // Pesan ketika tidak ada cast tersedia.
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(top: 16), // Padding atas agar lebih rapi.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Setiap baris memiliki 2 item (kolom).
        childAspectRatio: 2.5, // Perbandingan lebar dan tinggi item.
        crossAxisSpacing: 16, // Jarak horizontal antar item.
        mainAxisSpacing: 16, // Jarak vertikal antar item.
      ),
      itemCount: movie.cast.length, // Jumlah item sesuai jumlah cast.
      itemBuilder: (context, index) {
        final cast = movie.cast[index]; // Ambil data cast berdasarkan indeks.

        return Row(
          children: [
            // Menampilkan foto cast dalam bentuk avatar bulat.
            CircleAvatar(
              radius: 30, // Ukuran avatar.
              backgroundImage: NetworkImage(
                cast.profilePath?.isNotEmpty == true
                    ? "https://image.tmdb.org/t/p/w200${cast.profilePath}" // URL gambar cast jika tersedia.
                    : "https://via.placeholder.com/60", // Gambar placeholder jika tidak tersedia.
              ),
            ),
            const SizedBox(width: 12), // Jarak antara avatar dan teks.

            // Menampilkan nama cast dengan teks yang bisa di-truncate jika terlalu panjang.
            Expanded(
              child: Text(
                cast.name, // Nama pemeran.
                style: TextStyle(
                  color: getTextColor(context), // Warna teks sesuai tema.
                  fontWeight: FontWeight.bold, // Teks dengan gaya tebal.
                ),
                overflow: TextOverflow
                    .ellipsis, // Jika terlalu panjang, tampilkan "..."
              ),
            ),
          ],
        );
      },
    );
  }
}
