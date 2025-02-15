import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

/// Widget `ReviewsTab` menampilkan daftar ulasan (reviews) untuk sebuah film.
/// Jika tidak ada review, maka akan menampilkan tampilan 'Not Found'.
class ReviewsTab extends StatelessWidget {
  /// Objek model yang berisi detail film, termasuk daftar ulasan.
  final MovieDetailModel movie;

  /// Constructor menerima `movie` sebagai parameter yang harus diisi.
  const ReviewsTab({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // Jika tidak ada review, tampilkan widget NotFound dengan gambar dan pesan.
    if (movie.reviews.isEmpty) {
      return NotFound(
        image: 'assets/movie.png',
        title: 'No reviews found',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 16),
      itemCount: movie.reviews.length, // Jumlah item berdasarkan jumlah review
      itemBuilder: (context, index) {
        final review =
            movie.reviews[index]; // Mengambil review berdasarkan index

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black
                // ignore: deprecated_member_use
                .withOpacity(0.1), // Latar belakang dengan transparansi
            borderRadius: BorderRadius.circular(8), // Membuat sudut melengkung
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan avatar pengguna dan informasi reviewer
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/40'), // Gambar placeholder
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama penulis review
                      Text(
                        review.author,
                        style: TextStyle(
                          color: getTextColor(
                              context), // Warna teks disesuaikan dengan tema
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.amber,
                              size: 16), // Ikon bintang untuk rating
                          SizedBox(width: 4),
                          // Menampilkan rating dalam bentuk teks
                          Text(
                            review.rating.toString(),
                            style: TextStyle(
                              color: getTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Menampilkan isi review dengan batasan maksimal 3 baris
              Text(
                review.content,
                style: TextStyle(
                  color: getTextColor(context),
                ),
                maxLines: 3,
                overflow: TextOverflow
                    .ellipsis, // Jika lebih dari 3 baris, gunakan ellipsis (...)
              ),
            ],
          ),
        );
      },
    );
  }
}
