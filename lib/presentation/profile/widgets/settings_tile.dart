import 'package:flutter/material.dart';

/// **Widget `SettingsTile`**
///
/// `SettingsTile` adalah widget yang digunakan untuk menampilkan item dalam menu pengaturan.
/// Widget ini memiliki ikon, teks judul, dan tombol navigasi ke halaman lain.
///
/// **Fitur:**
/// - Menggunakan `InkWell` untuk memberikan efek klik.
/// - Memiliki ikon di sebelah kiri sebagai representasi dari fitur.
/// - Menampilkan teks judul dari pengaturan.
/// - Memiliki ikon panah (`chevron_right`) di sebelah kanan sebagai indikasi navigasi.
///
/// **Parameter:**
/// - `icon`: Ikon yang mewakili fitur pengaturan.
/// - `title`: Nama atau deskripsi singkat fitur pengaturan.
/// - `onTap`: Callback yang dipanggil saat item ditekan.
/// - `colorScheme`: Skema warna dari tema aplikasi yang digunakan untuk tampilan yang konsisten.
class SettingsTile extends StatelessWidget {
  /// Konstruktor `SettingsTile`
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.colorScheme,
  });

  /// Ikon yang ditampilkan di sebelah kiri item pengaturan.
  final IconData icon;

  /// Judul atau deskripsi fitur pengaturan.
  final String title;

  /// Fungsi callback yang dipanggil ketika item diklik.
  final VoidCallback onTap;

  /// Skema warna yang digunakan dalam tema aplikasi.
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /// **Efek klik pada item pengaturan**
      /// - Memberikan efek klik yang responsif saat pengguna menekan item.
      onTap: onTap,
      child: Padding(
        /// **Padding untuk tata letak yang lebih rapi**
        /// - Memberikan ruang 16px di semua sisi agar item tidak terlalu rapat.
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            /// **Ikon fitur pengaturan**
            /// - Ditampilkan di sebelah kiri.
            /// - Menggunakan warna `primary` dari `colorScheme`.
            Icon(icon, color: colorScheme.primary),

            /// **Jarak antara ikon dan teks**
            const SizedBox(width: 16),

            /// **Judul pengaturan**
            /// - Menggunakan `Expanded` agar teks menyesuaikan ruang yang tersedia.
            /// - Memiliki ukuran font `16px` dan menggunakan warna `onSurfaceVariant`.
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            /// **Ikon navigasi (`chevron_right`)**
            /// - Menunjukkan bahwa item dapat diklik untuk navigasi.
            /// - Menggunakan warna `onSurfaceVariant` dengan opasitas 50% agar lebih lembut.
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
