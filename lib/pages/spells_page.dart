import 'package:flutter/material.dart';
import '../models/spell.dart';
import '../repositories/favorite_repository.dart';
import '../repositories/spell_repository.dart';
import '../widgets/app_helpers.dart';
import 'favorite_spells_page.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({super.key});

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  final _fav = FavoriteRepository();
  final Future<List<Spell>> _future = SpellRepository().getSpells();

  Future<void> _toggle(Spell spell) async {
    if (_fav.isFavorite(spell.id)) {
      await _fav.remove(spell.id);
      if (!mounted) return;
      showTopSnackbar(context,
          title: 'Remove!',
          message: '${spell.name} removed from fav list!',
          success: false);
    } else {
      await _fav.add(spell);
      if (!mounted) return;
      showTopSnackbar(context,
          title: 'Add!',
          message: '${spell.name} successfully added to fav list!',
          success: true);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Spell>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final list = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final spell = list[i];
              final isFav = _fav.isFavorite(spell.id);
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(spell.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(spell.use),
                  trailing: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggle(spell),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.favorite, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FavoriteSpellsPage()),
          );
          setState(() {}); // perbarui ikon hati setelah kembali
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Characters'),
          ),
        ),
      ),
    );
  }
}