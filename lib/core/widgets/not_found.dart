import 'package:flutter/material.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';

/// **NotFound Widget**
///
/// Widget ini digunakan untuk menampilkan tampilan ketika suatu data tidak ditemukan.
/// Biasanya digunakan dalam kasus seperti pencarian kosong, halaman error, atau
/// daftar kosong dalam aplikasi.
///
/// **Parameter:**
/// - `image` (String): Path dari gambar aset yang akan ditampilkan.
/// - `title` (String): Teks yang akan ditampilkan di bawah gambar untuk memberikan informasi kepada pengguna.
///
/// **Cara Kerja:**
/// 1. Gambar ditampilkan di tengah layar menggunakan `Image.asset()`.
/// 2. Teks ditampilkan di bawah gambar dengan warna yang diambil dari fungsi `getTextColor(context)`.
///
/// **Contoh Penggunaan:**
/// ```dart
/// NotFound(
///   image: 'assets/images/not_found.png',
///   title: 'Data tidak ditemukan',
/// )
/// ```
class NotFound extends StatelessWidget {
  /// Path gambar yang akan ditampilkan sebagai indikator data tidak ditemukan.
  final String image;

  /// Teks yang akan ditampilkan di bawah gambar.
  final String title;

  /// Konstruktor untuk inisialisasi `image` dan `title`.
  const NotFound({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      /// Menengahkan seluruh konten dalam layar.
      child: Column(
        /// Mengatur jarak antar elemen dalam Column.
        mainAxisAlignment: MainAxisAlignment.center,

        /// Menengahkan semua elemen secara horizontal.
        crossAxisAlignment: CrossAxisAlignment.center,

        /// **NOTE:** `spacing: 8,` tidak valid dalam `Column`, kemungkinan ini adalah typo.
        /// Jika ingin memberi jarak antar elemen, gunakan `SizedBox` di antara elemen.
        children: [
          /// Menampilkan gambar dari aset dengan ukuran yang sudah ditentukan.
          Image.asset(
            image, // Path gambar dari parameter
            width: 100, // Lebar gambar
            height: 100, // Tinggi gambar
          ),

          /// Memberikan sedikit jarak antara gambar dan teks.
          const SizedBox(height: 8),

          /// Menampilkan teks dengan warna yang sesuai dengan tema aplikasi.
          Text(
            title, // Teks yang ditampilkan
            style: TextStyle(
              color:
                  getTextColor(context), // Warna teks dinamis berdasarkan tema
              fontWeight: FontWeight.bold, // Membuat teks menjadi tebal
            ),
          ),
        ],
      ),
    );
  }
}
