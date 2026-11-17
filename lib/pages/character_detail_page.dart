import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  String _format(dynamic value) {
    if (value == null || value == '') return '-';
    if (value is List) return value.isEmpty ? '-' : value.join(', ');
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.fullName)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Image.network(
            character.image,
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
            const SizedBox(height: 300, child: Icon(Icons.person, size: 120)),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: character.raw.entries
                  .map((e) => ListTile(
                dense: true,
                title: Text(e.key,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_format(e.value)),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}