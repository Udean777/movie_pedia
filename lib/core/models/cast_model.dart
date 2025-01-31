class CastModel {
  final int id;
  final String name;
  final String? profilePath;

  CastModel({
    required this.id,
    required this.name,
    this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profilePath: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}'
          : null,
    );
  }
}
