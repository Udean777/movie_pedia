/// Model data untuk review film, digunakan untuk menyimpan informasi ulasan yang diberikan oleh pengguna.
class ReviewModel {
  /// ID unik untuk setiap review.
  final String id;

  /// Nama penulis review.
  final String author;

  /// Isi atau konten dari review.
  final String content;

  /// Nilai rating yang diberikan oleh penulis review.
  final double rating;

  /// URL avatar penulis review, dapat `null` jika tidak tersedia.
  final String? avatarPath;

  /// Konstruktor untuk `ReviewModel`.
  ///
  /// - `id`, `author`, `content`, dan `rating` bersifat `required` agar data utama selalu tersedia.
  /// - `avatarPath` bersifat opsional (`nullable`), karena tidak semua pengguna memiliki avatar.
  ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    required this.rating,
    this.avatarPath,
  });

  /// Factory constructor untuk membuat objek `ReviewModel` dari JSON.
  ///
  /// - Menangani kemungkinan nilai `null` dengan memberikan nilai default yang sesuai.
  /// - `rating` dikonversi menjadi `double` untuk memastikan formatnya konsisten.
  /// - `avatarPath` diubah menjadi URL lengkap jika tersedia, atau `null` jika tidak ada.
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '', // Jika `id` tidak tersedia, gunakan string kosong
      author: json['author'] ??
          '', // Jika `author` tidak tersedia, gunakan string kosong
      content: json['content'] ??
          '', // Jika `content` tidak tersedia, gunakan string kosong
      rating: ((json['author_details']?['rating'] ?? 0) as num)
          .toDouble(), // Konversi rating ke double
      avatarPath: json['author_details']?['avatar_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['author_details']['avatar_path']}' // URL avatar TMDB
          : null, // Jika avatar tidak tersedia, gunakan null
    );
  }

  /// Mengonversi objek `ReviewModel` menjadi `Map<String, dynamic>`.
  ///
  /// Digunakan untuk menyimpan atau mengirim data dalam format map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'rating': rating,
      'avatarPath': avatarPath,
    };
  }
}
