import 'package:flutter/material.dart';
import '../models/player.dart';
import '../services/player_profile_service.dart';
import '../widgets/game_background.dart';
import 'score_screen.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({super.key});

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  final _thresholdController = TextEditingController();
  final _taskController = TextEditingController();

  final PlayerProfileService _profileService = PlayerProfileService();
  List<String> _allProfiles = [];
  final List<String> _selectedPlayers = [];
  final List<String> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    setState(() {
      _isLoading = true;
    });
    final profiles = await _profileService.loadPlayers();
    setState(() {
      _allProfiles = profiles;
      _isLoading = false;
    });
  }

  void _togglePlayerSelection(String name) {
    setState(() {
      if (_selectedPlayers.contains(name)) {
        _selectedPlayers.remove(name);
      } else {
        _selectedPlayers.add(name);
      }
    });
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  void _startGame() {
    final threshold = int.tryParse(_thresholdController.text);
    if (_selectedPlayers.length >= 2 &&
        threshold != null &&
        _tasks.isNotEmpty) {
      final playersForGame = _selectedPlayers
          .map((name) => Player(name: name))
          .toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            players: playersForGame,
            threshold: threshold,
            tasks: _tasks,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'NEED 2+ PLAYERS, A THRESHOLD, AND 1+ TASK',
            style: TextStyle(fontFamily: 'PressStart2P'),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('GAME SETUP'), centerTitle: true),
      body: GameBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSectionTitle('SELECT PLAYERS (MIN 2)'),
              const SizedBox(height: 10),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _allProfiles.isEmpty
                  ? const Center(child: Text('NO PROFILES FOUND. ADD SOME!'))
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _allProfiles.map((name) {
                        final isSelected = _selectedPlayers.contains(name);
                        return ActionChip(
                          label: Text(name),
                          onPressed: () => _togglePlayerSelection(name),
                          backgroundColor: isSelected
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.surface,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 30),
              _buildSectionTitle('SET THRESHOLD'),
              TextField(
                controller: _thresholdController,
                decoration: const InputDecoration(labelText: 'LOSING SCORE'),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 30),
              _buildSectionTitle('CREATE TASKS (MIN 1)'),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'TASK DESCRIPTION',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: _addTask,
                  ),
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _tasks
                    .map(
                      (task) => Chip(
                        label: Text(task),
                        onDeleted: () {
                          setState(() {
                            _tasks.remove(task);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _startGame,
                child: const Text('START SCORING'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 16,
      ),
    );
  }
}
