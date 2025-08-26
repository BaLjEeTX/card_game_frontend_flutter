import 'package:flutter/material.dart';
import '../widgets/game_background.dart';
import 'game_setup_screen.dart';
import 'leaderboard_screen.dart';
import 'player_profiles_screen.dart'; // <-- Added import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 28,
      color: Theme.of(context).colorScheme.secondary,
      shadows: const [
        Shadow(blurRadius: 10.0, color: Colors.black, offset: Offset(2.0, 2.0)),
      ],
    );

    return Scaffold(
      body: GameBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('L E V E L', style: textStyle),
                Text('D O W N', style: textStyle),
                const SizedBox(height: 60),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameSetupScreen(),
                      ),
                    );
                  },
                  child: const Text('START GAME'),
                ),

                const SizedBox(height: 20),

                // --- New "Player Profiles" button ---
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayerProfilesScreen(),
                      ),
                    );
                  },
                  child: const Text('PLAYER PROFILES'),
                ),

                const SizedBox(height: 20),

                // --- Existing "Hall of Shame" button ---
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeaderboardScreen(),
                      ),
                    );
                  },
                  child: const Text('HALL OF SHAME'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
