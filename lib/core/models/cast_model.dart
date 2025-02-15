/// Model data untuk aktor (cast) dalam sebuah film.
class CastModel {
  /// ID unik untuk aktor.
  final int id;

  /// Nama aktor.
  final String name;

  /// URL gambar profil aktor (opsional, bisa null jika tidak tersedia).
  final String? profilePath;

  /// Nama karakter yang diperankan oleh aktor dalam film.
  final String character;

  /// Konstruktor untuk `CastModel`.
  CastModel({
    required this.id,
    required this.name,
    this.profilePath,
    required this.character,
  });

  /// Factory constructor untuk membuat `CastModel` dari JSON.
  /// - Jika `profile_path` tersedia, maka akan dikonversi ke URL lengkap.
  /// - Jika `profile_path` tidak ada, nilainya akan menjadi `null`.
  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0, // Jika tidak ada ID, gunakan default 0.
      name: json['name'] ?? '', // Jika tidak ada nama, gunakan string kosong.
      profilePath: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}' // Format URL gambar.
          : null, // Jika tidak ada gambar, set null.
      character: json['character'] ??
          '', // Jika tidak ada karakter, gunakan string kosong.
    );
  }

  /// Mengubah `CastModel` menjadi Map (format yang dapat disimpan dalam database atau digunakan lebih lanjut).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePath': profilePath,
      'character': character,
    };
  }
}
