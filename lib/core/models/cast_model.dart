class CastModel {
  final int id;
  final String name;
  final String? profilePath;
  final String character;

  CastModel({
    required this.id,
    required this.name,
    this.profilePath,
    required this.character,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profilePath: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}'
          : null,
      character: json['character'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePath': profilePath,
      'character': character,
    };
  }
}
