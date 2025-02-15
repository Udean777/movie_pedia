import 'package:flutter/material.dart';

/// **Widget `InfoTile`**
///
/// `InfoTile` adalah widget yang digunakan untuk menampilkan informasi dalam bentuk
/// ikon, judul, dan nilai (value). Biasanya digunakan untuk menampilkan informasi
/// profil pengguna, seperti email atau tanggal bergabung.
///
/// **Parameter:**
/// - `icon`: Ikon yang mewakili informasi (misalnya, ikon email).
/// - `title`: Judul informasi (misalnya, "Email" atau "Member Since").
/// - `value`: Nilai informasi yang ditampilkan.
/// - `colorScheme`: Skema warna dari tema aplikasi untuk konsistensi warna.
class InfoTile extends StatelessWidget {
  /// Konstruktor `InfoTile`
  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.colorScheme,
  });

  /// Ikon yang merepresentasikan informasi (misalnya, `Icons.email_outlined`).
  final IconData icon;

  /// Judul informasi (misalnya, "Email" atau "Member Since").
  final String title;

  /// Nilai dari informasi yang akan ditampilkan (misalnya, email pengguna).
  final String value;

  /// Skema warna yang digunakan dalam tema aplikasi.
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical:
              8.0), // Padding atas dan bawah untuk memberikan ruang antar item.
      child: Row(
        children: [
          /// **Ikon Informasi**
          /// - Warna ikon diambil dari `colorScheme.primary`.
          Icon(icon, color: colorScheme.primary),

          const SizedBox(width: 16), // Memberikan jarak antara ikon dan teks.

          /// **Teks Informasi**
          /// - `Column` digunakan untuk menampilkan judul dan nilai informasi secara vertikal.
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Teks diratakan ke kiri.
            children: [
              /// **Judul Informasi**
              /// - Ditampilkan dalam warna `onSurfaceVariant`.
              /// - Menggunakan font dengan ketebalan `FontWeight.w500` agar lebih menonjol.
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                  height:
                      4), // Memberikan sedikit jarak antara judul dan nilai.

              /// **Nilai Informasi**
              /// - Ditampilkan dalam warna `onSurfaceVariant`.
              /// - Menggunakan ukuran font `16` agar lebih mudah dibaca.
              Text(
                value,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
