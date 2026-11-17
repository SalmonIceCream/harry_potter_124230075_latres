class Spell {
  final String id;
  final String name;
  final String use;

  Spell({required this.id, required this.name, required this.use});

  factory Spell.fromJson(Map<String, dynamic> json) {
    final rawId = json['index'] ?? json['_id'] ?? json['id'];
    final id = rawId != null ? rawId.toString() : (json['spell'] ?? '');
    return Spell(
      id: id,
      name: json['spell'] ?? '-',
      use: json['use'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() => {'index': id, 'spell': name, 'use': use};
}