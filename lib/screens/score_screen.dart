import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/player.dart';
import '../widgets/game_background.dart';
import '../widgets/player_card.dart';
import 'flash_screen.dart';
import '../services/leaderboard_service.dart'; // <-- Added import

class ScoreScreen extends StatefulWidget {
  final List<Player> players;
  final int threshold;
  final List<String> tasks;

  const ScoreScreen({
    super.key,
    required this.players,
    required this.threshold,
    required this.tasks,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  // --- Dialog for adding score ---
  void _showAddScoreDialog(Player player) {
    final scoreController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Score for ${player.name}'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: scoreController,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*')),
              ],
              decoration: const InputDecoration(
                labelText: 'Score to add (e.g., 50 or -20)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value == '-') {
                  return 'Please enter a valid score';
                }
                if (int.tryParse(value) == null) {
                  return 'Invalid number';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final scoreToAdd = int.parse(scoreController.text);
                  _updateScore(player, scoreToAdd);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // --- Update score & check threshold ---
  void _updateScore(Player player, int amount) {
    setState(() {
      player.score += amount;
    });

    if (player.score >= widget.threshold) {
      // --- NEW: Save the loss before continuing ---
      LeaderboardService().saveLoss(player.name);

      final randomTask = widget.tasks[Random().nextInt(widget.tasks.length)];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlashScreen(playerName: player.name),
        ),
      ).then((_) {
        _showLoserPopup(player, randomTask);
      });
    }
  }

  // --- Show loser popup ---
  void _showLoserPopup(Player player, String task) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('${player.name} Lost!'),
        content: Text(
          '${player.name} reached ${player.score} points '
          '(threshold was ${widget.threshold}).\n\n'
          'Your honorable task is:\n\n"$task"',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: const Text('Start New Round'),
          ),
        ],
      ),
    );
  }

  // --- Reset game ---
  void _resetGame() {
    setState(() {
      for (var player in widget.players) {
        player.score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('SCOREBOARD'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'RESET SCORES',
            onPressed: _resetGame,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
      body: GameBackground(
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemCount: widget.players.length,
            itemBuilder: (context, index) {
              final player = widget.players[index];
              return PlayerCard(
                player: player,
                onAddScore: () => _showAddScoreDialog(player),
              );
            },
          ),
        ),
      ),
    );
  }
}
