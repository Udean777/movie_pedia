import 'package:flutter/material.dart';

/// **Widget `StatCard`**
///
/// `StatCard` adalah widget statis yang menampilkan informasi statistik dalam bentuk kartu.
/// Kartu ini berisi ikon, angka (count), dan judul yang mendeskripsikan statistik yang ditampilkan.
///
/// **Fitur:**
/// - Menggunakan `Card` sebagai wadah utama.
/// - Ikon yang merepresentasikan jenis statistik.
/// - Angka dengan ukuran besar untuk menunjukkan nilai statistik.
/// - Judul sebagai deskripsi dari statistik.
///
/// **Parameter:**
/// - `colorScheme`: Skema warna yang digunakan untuk memastikan warna sesuai dengan tema aplikasi.
/// - `title`: Judul atau deskripsi statistik yang ditampilkan.
/// - `count`: Angka yang menunjukkan jumlah statistik.
/// - `icon`: Ikon yang merepresentasikan statistik tersebut.
class StatCard extends StatelessWidget {
  /// Konstruktor `StatCard`
  const StatCard({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.count,
    required this.icon,
  });

  /// Skema warna yang digunakan dalam tema aplikasi.
  final ColorScheme colorScheme;

  /// Judul statistik yang menjelaskan jenis data yang ditampilkan.
  final String title;

  /// Angka statistik yang ditampilkan dalam kartu.
  final String count;

  /// Ikon yang menggambarkan kategori statistik.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      /// **Kartu tanpa bayangan (`elevation: 0`)**
      /// - Menampilkan statistik dalam bentuk kartu.
      /// - Menggunakan warna `primaryContainer` dari skema warna agar konsisten dengan tema.
      elevation: 0,
      color: colorScheme.primaryContainer,
      child: Padding(
        /// **Padding untuk memberikan ruang yang cukup dalam kartu**
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// **Ikon Statistik**
            /// - Menampilkan ikon yang sesuai dengan kategori statistik.
            /// - Menggunakan warna `onPrimaryContainer` agar kontras dengan latar belakang.
            Icon(
              icon,
              color: colorScheme.onPrimaryContainer,
              size: 28,
            ),

            /// **Jarak antara ikon dan angka**
            const SizedBox(height: 8),

            /// **Angka Statistik**
            /// - Ditampilkan dalam ukuran besar (`fontSize: 24`) agar lebih menonjol.
            /// - Menggunakan warna `onPrimaryContainer` agar kontras dengan latar belakang.
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),

            /// **Jarak antara angka dan judul**
            const SizedBox(height: 4),

            /// **Judul Statistik**
            /// - Menjelaskan angka yang ditampilkan.
            /// - Menggunakan warna `onPrimaryContainer` agar tetap terbaca dengan baik.
            Text(
              title,
              style: TextStyle(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
