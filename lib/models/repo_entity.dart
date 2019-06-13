class RepoEntity {

  const RepoEntity({
    this.name,
    this.fullName,
    this.stars,
  });

  final String name;
  final String fullName;
  final int stars;

  factory RepoEntity.fromJson(Map<String, dynamic> json) {
    return  RepoEntity(
      name: json['name'],
      fullName: json['full_name'],
      stars: json['stargazers_count'],
    );
  }

  RepoEntity copyWith({
    final String name,
    final String fullName,
    final int stars,
  }) {
    return  RepoEntity(
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      stars: stars ?? this.stars,
    );
  }
}