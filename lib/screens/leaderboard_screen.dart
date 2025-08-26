import 'package:flutter/material.dart';
import '../services/leaderboard_service.dart';
import '../widgets/game_background.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final LeaderboardService _service = LeaderboardService();
  late Future<List<MapEntry<String, int>>> _leaderboardFuture;

  @override
  void initState() {
    super.initState();
    _leaderboardFuture = _loadAndSortLeaderboard();
  }

  Future<List<MapEntry<String, int>>> _loadAndSortLeaderboard() async {
    final data = await _service.loadLeaderboard();
    // Convert map entries to a list and sort it in descending order of losses.
    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedEntries;
  }

  void _clearLeaderboard() {
    setState(() {
      _service.clearLeaderboard();
      // Reload the data after clearing to update the UI.
      _leaderboardFuture = _loadAndSortLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('HALL OF SHAME'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Clear History',
            onPressed: _clearLeaderboard,
          ),
        ],
      ),
      body: GameBackground(
        child: SafeArea(
          child: FutureBuilder<List<MapEntry<String, int>>>(
            future: _leaderboardFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              }

              final leaderboard = snapshot.data;

              if (leaderboard == null || leaderboard.isEmpty) {
                return const Center(
                  child: Text(
                    'NO ONE HAS LOST YET!\n\nPLAY A GAME!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  final entry = leaderboard[index];
                  final rank = index + 1;
                  final playerName = entry.key;
                  final lossCount = entry.value;

                  return Card(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withOpacity(0.8),
                    child: ListTile(
                      leading: Text(
                        '$rank.',
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      title: Text(
                        playerName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: Text(
                        'LOSSES: $lossCount',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
