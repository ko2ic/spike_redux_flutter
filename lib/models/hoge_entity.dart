class HogeEntity {
  final String fuga;

  const HogeEntity({
    this.fuga,
  });

  factory HogeEntity.fromJson(Map<String, dynamic> json) {
    return HogeEntity(fuga: json['fuga']);
  }
}
