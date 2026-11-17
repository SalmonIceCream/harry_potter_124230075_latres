import 'package:flutter/material.dart';
import '../models/spell.dart';
import '../repositories/favorite_repository.dart';
import '../services/notification_service.dart';

class FavoriteSpellsPage extends StatefulWidget {
  const FavoriteSpellsPage({super.key});

  @override
  State<FavoriteSpellsPage> createState() => _FavoriteSpellsPageState();
}

class _FavoriteSpellsPageState extends State<FavoriteSpellsPage> {
  final _fav = FavoriteRepository();
  late List<Spell> _items = _fav.getAll();

  Future<void> _delete(Spell spell) async {
    await _fav.remove(spell.id);
    await NotificationService.showDeleteNotification(spell.name);
    if (!mounted) return;
    setState(() => _items = _fav.getAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Spell')),
      body: _items.isEmpty
          ? const Center(child: Text('Belum ada spell favorit'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final spell = _items[i];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book),
              title: Text(spell.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(spell.use),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _delete(spell),
              ),
            ),
          );
        },
      ),
    );
  }
}