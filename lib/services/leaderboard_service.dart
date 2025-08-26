import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaderboardService {
  // --- IMPORTANT ---
  // For Android Emulator, use 10.0.2.2 to connect to your computer's localhost.
  // For iOS Simulator, 'localhost' or '127.0.0.1' usually works.
  // If running on a real device, use your computer's network IP address (e.g., 192.168.1.100).
  static const String _baseUrl =
      'https://cardgame-backend-7yl8.onrender.com/leaderboard';
  // ----------------

  Future<Map<String, int>> loadLeaderboard() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> playersJson = jsonDecode(response.body);
        final Map<String, int> leaderboard = {
          for (var player in playersJson)
            player['name']: player['losses'] as int,
        };
        return leaderboard;
      } else {
        throw Exception('Failed to load leaderboard');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> saveLoss(String playerName) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/loss'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': playerName}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save loss');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> clearLeaderboard() async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl));

      if (response.statusCode != 200) {
        throw Exception('Failed to clear leaderboard');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to the server');
    }
  }
}
