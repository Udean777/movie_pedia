import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/profile/widgets/info_tile.dart';

/// **Widget `InfoCard`**
/// `InfoCard` adalah kartu informasi yang menampilkan detail pengguna yang sedang login,
/// seperti email dan tanggal pembuatan akun.
///
/// Widget ini menggunakan `Card` sebagai tampilan utama dengan beberapa informasi
/// yang diatur menggunakan widget `InfoTile`.
///
/// **Parameter:**
/// - `colorScheme`: Skema warna aplikasi untuk menyesuaikan warna tampilan.
/// - `user`: Objek `User` dari Firebase Authentication yang berisi data pengguna.
class InfoCard extends StatelessWidget {
  /// Konstruktor `InfoCard`
  const InfoCard({
    super.key,
    required this.colorScheme,
    required this.user,
  });

  /// Skema warna dari tema aplikasi
  final ColorScheme colorScheme;

  /// Objek pengguna yang sedang login (nullable)
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Menghilangkan efek bayangan pada kartu
      color: colorScheme
          .surfaceContainerHighest, // Warna latar belakang sesuai tema
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di dalam kartu
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Menyusun konten ke kiri
          children: [
            /// **InfoTile untuk Email**
            /// - Menampilkan alamat email pengguna.
            /// - Jika email tidak tersedia, ditampilkan "Not available".
            InfoTile(
              icon: Icons.email_outlined,
              title: 'Email',
              value: user?.email ?? 'Not available',
              colorScheme: colorScheme,
            ),
            const Divider(), // Garis pemisah antar informasi

            /// **InfoTile untuk Tanggal Bergabung**
            /// - Menampilkan tanggal pembuatan akun dari Firebase.
            /// - Format yang digunakan hanya menampilkan tanggal (tanpa jam).
            /// - Jika tidak tersedia, ditampilkan "Not available".
            InfoTile(
              icon: Icons.access_time,
              title: 'Member Since',
              value: user?.metadata.creationTime?.toString().split(' ')[0] ??
                  'Not available',
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}
