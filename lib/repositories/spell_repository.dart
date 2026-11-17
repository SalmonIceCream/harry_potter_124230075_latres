import '../models/spell.dart';
import '../services/api_client.dart';

class SpellRepository {
  final _api = ApiClient();

  Future<List<Spell>> getSpells() async {
    final data = await _api.getList('spells');
    return data.map(Spell.fromJson).toList();
  }
}