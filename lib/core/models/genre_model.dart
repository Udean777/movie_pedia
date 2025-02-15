/// Model data untuk genre film.
class GenreModel {
  /// ID unik genre.
  final int id;

  /// Nama genre (misalnya: Action, Comedy, Drama).
  final String name;

  /// Konstruktor untuk `GenreModel`.
  GenreModel({required this.id, required this.name});

  /// Factory constructor untuk membuat `GenreModel` dari JSON.
  /// - Jika `id` tidak tersedia, nilai default adalah `0`.
  /// - Jika `name` tidak tersedia, nilai default adalah string kosong (`""`).
  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  /// Mengubah `GenreModel` menjadi Map, berguna untuk penyimpanan atau pengolahan lebih lanjut.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
