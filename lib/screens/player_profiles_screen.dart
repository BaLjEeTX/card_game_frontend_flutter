import 'package:flutter/material.dart';
import '../services/player_profile_service.dart';
import '../widgets/game_background.dart';

class PlayerProfilesScreen extends StatefulWidget {
  const PlayerProfilesScreen({super.key});

  @override
  State<PlayerProfilesScreen> createState() => _PlayerProfilesScreenState();
}

class _PlayerProfilesScreenState extends State<PlayerProfilesScreen> {
  final PlayerProfileService _service = PlayerProfileService();
  final _playerNameController = TextEditingController();
  List<String> _players = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    setState(() {
      _isLoading = true;
    });
    final players = await _service.loadPlayers();
    setState(() {
      _players = players;
      _isLoading = false;
    });
  }

  Future<void> _addPlayer() async {
    final name = _playerNameController.text.trim();
    if (name.isNotEmpty) {
      await _service.addPlayer(name);
      _playerNameController.clear();
      await _loadPlayers(); // Reload to show the new player
    }
  }

  Future<void> _deletePlayer(String name) async {
    await _service.deletePlayer(name);
    await _loadPlayers(); // Reload to reflect the deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('PLAYER PROFILES'), centerTitle: true),
      body: GameBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _players.isEmpty
                    ? const Center(
                        child: Text(
                          'ADD PLAYERS TO YOUR ROSTER!',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _players.length,
                        itemBuilder: (context, index) {
                          final player = _players[index];
                          return Card(
                            color: Theme.of(
                              context,
                            ).colorScheme.surface.withOpacity(0.8),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: ListTile(
                              title: Text(
                                player,
                                style: const TextStyle(fontSize: 18),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () => _deletePlayer(player),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              // Input field at the bottom
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _playerNameController,
                  decoration: InputDecoration(
                    labelText: 'ADD NEW PLAYER NAME',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,
                      ),
                      onPressed: _addPlayer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
