import 'package:flutter/material.dart';
import '../models/player.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final VoidCallback onAddScore;

  const PlayerCard({super.key, required this.player, required this.onAddScore});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Player Name and Score
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'SCORE: ${player.score}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            // Add Score Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: onAddScore,
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
