import 'package:shared_preferences/shared_preferences.dart';

class PlayerProfileService {
  static const _playerProfilesKey = 'player_profiles';

  // Load the saved list of player names.
  Future<List<String>> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_playerProfilesKey) ?? [];
  }

  // A private helper to save the list of player names.
  Future<void> _savePlayers(List<String> players) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_playerProfilesKey, players);
  }

  // Add a new player to the list if they don't already exist.
  Future<void> addPlayer(String name) async {
    if (name.isEmpty) return;
    final players = await loadPlayers();
    // Use a case-insensitive check to prevent duplicate names like 'BOB' and 'bob'.
    if (!players.any((p) => p.toUpperCase() == name.toUpperCase())) {
      players.add(name);
      await _savePlayers(players);
    }
  }

  // Delete a player from the list.
  Future<void> deletePlayer(String name) async {
    final players = await loadPlayers();
    players.removeWhere((p) => p.toUpperCase() == name.toUpperCase());
    await _savePlayers(players);
  }
}
