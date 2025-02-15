import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/about_movie_tab.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/cast_tab.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/reviews_tab.dart';

/// Widget `MovieInfo` menampilkan informasi dasar tentang film
/// seperti tahun rilis, durasi, dan genre, serta menyediakan tab navigasi
/// untuk menampilkan detail tambahan seperti ulasan, informasi film, dan daftar pemeran.
class MovieInfo extends StatelessWidget {
  /// Model yang berisi detail film, termasuk genre, runtime, dan review.
  final MovieDetailModel movie;

  /// Constructor menerima `movie` sebagai parameter wajib.
  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan skema warna dari tema aplikasi
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Menampilkan informasi dasar film dalam satu baris:
          /// - Tahun rilis
          /// - Durasi film
          /// - Genre utama
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Tahun rilis film (diambil dari tanggal rilis dengan format YYYY-MM-DD)
              Text(
                movie.releaseDate.split('-')[0], // Hanya mengambil tahun
                style: TextStyle(
                  color: getTextColor(
                      context), // Menyesuaikan warna teks sesuai tema
                ),
              ),
              // Simbol pemisah
              Text(
                '•',
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              // Durasi film dalam menit
              Text(
                '${movie.runtime} Minutes',
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              // Simbol pemisah
              Text(
                '•',
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              // Genre pertama dari daftar genre yang tersedia
              Text(
                movie.genres.first.name,
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          /// Menggunakan `DefaultTabController` untuk menyediakan navigasi tab
          DefaultTabController(
            length: 3, // Jumlah tab
            child: Column(
              children: [
                /// TabBar dalam sebuah container dengan desain melengkung dan warna yang sesuai tema
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colorScheme
                        .surfaceContainerHighest, // Warna latar belakang tab
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    tabs: const [
                      Tab(text: 'About'), // Tab untuk deskripsi film
                      Tab(text: 'Reviews'), // Tab untuk ulasan film
                      Tab(text: 'Cast'), // Tab untuk daftar pemeran
                    ],
                    labelColor: colorScheme.onSurface, // Warna teks tab aktif
                    unselectedLabelColor: colorScheme
                        .onSurfaceVariant, // Warna teks tab tidak aktif
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    // Indikator tab aktif dengan efek border radius
                    indicator: BoxDecoration(
                      color: colorScheme
                          .primaryContainer, // Warna indikator tab aktif
                      borderRadius: BorderRadius.circular(12),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor:
                        Colors.transparent, // Menghilangkan garis bawah TabBar
                    splashBorderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.all(4),
                  ),
                ),

                /// TabBarView menampilkan konten sesuai dengan tab yang dipilih
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      400, // Menentukan tinggi TabBarView
                  child: TabBarView(
                    children: [
                      AboutMovieTab(movie: movie), // Tab berisi deskripsi film
                      ReviewsTab(movie: movie), // Tab berisi daftar ulasan film
                      CastTab(movie: movie), // Tab berisi daftar pemeran film
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
