import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/spell.dart';

class FavoriteRepository {
  static const _boxName = 'favorites';

  static Future<void> init() async {
    await Hive.openBox<String>(_boxName);
  }

  Box<String> get _box => Hive.box<String>(_boxName);

  List<Spell> getAll() =>
      _box.values.map((e) => Spell.fromJson(jsonDecode(e))).toList();

  bool isFavorite(String id) => id.isNotEmpty && _box.containsKey(id);

  Future<void> add(Spell spell) async {
    if (spell.id.isNotEmpty) {
      await _box.put(spell.id, jsonEncode(spell.toJson()));
    }
  }

  Future<void> remove(String id) async {
    if (id.isNotEmpty) {
      await _box.delete(id);
    }
  }
}