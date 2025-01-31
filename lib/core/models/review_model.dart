class ReviewModel {
  final String id;
  final String author;
  final String content;
  final double rating;

  ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      rating: ((json['author_details']['rating'] ?? 0) as num).toDouble(),
    );
  }
}
