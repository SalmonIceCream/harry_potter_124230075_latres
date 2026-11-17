class Character {
  final String id;
  final String fullName;
  final String interpretedBy;
  final String image;
  final Map<String, dynamic> raw; // semua property dari API, untuk halaman detail

  Character({
    required this.id,
    required this.fullName,
    required this.interpretedBy,
    required this.image,
    required this.raw,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final rawId = json['index'] ?? json['_id'] ?? json['id'];
    final id = rawId != null ? rawId.toString() : (json['fullName'] ?? '');
    return Character(
      id: id,
      fullName: json['fullName'] ?? '-',
      interpretedBy: json['interpretedBy'] ?? '-',
      image: json['image'] ?? '',
      raw: json,
    );
  }
}