/// Model untuk menyimpan data film yang diinginkan pengguna (wishlist).
class WishlistMovie {
  /// ID unik film (biasanya dari TMDB).
  final String id;

  /// ID pengguna yang menambahkan film ini ke wishlist.
  final String userId;

  /// Judul film.
  final String title;

  /// URL path untuk poster film.
  final String posterPath;

  /// Rata-rata penilaian film berdasarkan TMDB.
  final double voteAverage;

  /// Daftar ID genre yang terkait dengan film ini.
  final List<int> genreIds;

  /// Durasi film dalam menit (opsional).
  final int? runtime;

  /// Konstruktor untuk membuat instance `WishlistMovie`.
  WishlistMovie({
    required this.id,
    required this.userId,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    this.runtime,
  });

  /// Mengonversi objek `WishlistMovie` menjadi `Map<String, dynamic>`.
  ///
  /// Fungsi ini berguna saat ingin menyimpan data ke database atau API.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId, // Menyimpan ID pengguna
      'title': title, // Menyimpan judul film
      'posterPath': posterPath, // Menyimpan path poster film
      'voteAverage': voteAverage, // Menyimpan rating film
      // Mengubah list genre ID menjadi string yang dipisahkan koma untuk penyimpanan
      'genreIds': genreIds.map((e) => e.toString()).join(','),
      'runtime': runtime, // Menyimpan durasi film (jika ada)
    };
  }

  /// Mengonversi `Map<String, dynamic>` menjadi objek `WishlistMovie`.
  ///
  /// Biasanya digunakan saat mengambil data dari database atau API.
  ///
  /// - [id]: ID unik film yang akan digunakan untuk pembuatan objek `WishlistMovie`.
  /// - [data]: Data film dalam bentuk `Map<String, dynamic>` yang berisi informasi film.
  ///
  /// Mengembalikan instance `WishlistMovie`.
  static WishlistMovie fromMap(String id, Map<String, dynamic> data) {
    return WishlistMovie(
      id: id, // Menggunakan ID dari sumber data
      userId: data['userId'] ??
          '', // Mengambil ID pengguna, default ke string kosong jika null
      title: data['title'], // Mengambil judul film
      posterPath: data['posterPath'], // Mengambil URL poster film
      voteAverage: (data['voteAverage'])
          .toDouble(), // Konversi nilai rating ke tipe double
      // Mengonversi string genre yang dipisahkan koma kembali ke list integer
      genreIds: data['genreIds'] != null
          ? List<int>.from(data['genreIds'].split(',').map((e) => int.parse(e)))
          : [],
      runtime: data['runtime'], // Mengambil durasi film (jika ada)
    );
  }
}
