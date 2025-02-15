class WishlistMovie {
  final String id;
  final String userId;
  final String title;
  final String posterPath;
  final double voteAverage;
  final List<int> genreIds;
  final int? runtime;

  WishlistMovie({
    required this.id,
    required this.userId,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    this.runtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'genreIds': genreIds.map((e) => e.toString()).join(','),
      'runtime': runtime,
    };
  }

  static WishlistMovie fromMap(String id, Map<String, dynamic> data) {
    return WishlistMovie(
      id: id,
      userId: data['userId'] ?? '',
      title: data['title'],
      posterPath: data['posterPath'],
      voteAverage: (data['voteAverage']).toDouble(),
      genreIds: data['genreIds'] != null
          ? List<int>.from(data['genreIds'].split(',').map((e) => int.parse(e)))
          : [],
      runtime: data['runtime'],
    );
  }
}
