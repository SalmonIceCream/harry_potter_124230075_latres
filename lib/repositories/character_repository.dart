import '../models/character.dart';
import '../services/api_client.dart';

class CharacterRepository {
  final _api = ApiClient();

  Future<List<Character>> getCharacters() async {
    final data = await _api.getList('characters');
    return data.map(Character.fromJson).toList();
  }
}