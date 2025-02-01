class ReviewModel {
  final String id;
  final String author;
  final String content;
  final double rating;
  final String? avatarPath;

  ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    required this.rating,
    this.avatarPath,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      rating: ((json['author_details']?['rating'] ?? 0) as num).toDouble(),
      avatarPath: json['author_details']?['avatar_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['author_details']['avatar_path']}'
          : null,
    );
  }

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
