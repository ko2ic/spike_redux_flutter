class RepoEntity {

  const RepoEntity({
    this.name,
    this.fullName,
    this.stars,
    this.isFavorite = false,
  });

  final String name;
  final String fullName;
  final int stars;
  final bool isFavorite;

  factory RepoEntity.fromJson(Map<String, dynamic> json) {
    return new RepoEntity(
      name: json['name'],
      fullName: json['full_name'],
      stars: json['stargazers_count'],
    );
  }

  RepoEntity copyWith({
    final String name,
    final String fullName,
    final int stars,
    final bool isFavorite,
  }) {
    return new RepoEntity(
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      stars: stars ?? this.stars,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}