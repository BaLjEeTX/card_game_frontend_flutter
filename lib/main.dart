import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CardScoreTrackerApp());
}

class CardScoreTrackerApp extends StatelessWidget {
  const CardScoreTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Score Tracker',
      theme: ThemeData(
        // The core game theme
        fontFamily: 'PressStart2P', // Set the default font
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6200EE), // A vibrant purple
        // Define a custom color scheme
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFBB86FC), // Lighter purple for primary elements
          secondary: Color(0xFF03DAC6), // Very dark background
          surface: Color(0xFF1E1E1E), // Slightly lighter for card backgrounds
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
        ),

        // Style various UI components
        scaffoldBackgroundColor: const Color(0xFF121212),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Make AppBar transparent
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 20,
            color: Color(0xFF03DAC6), // Accent color for title
          ),
        ),

        // Style buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF03DAC6), // Accent color
            foregroundColor: Colors.black, // Black text on buttons
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Color(0xFFBB86FC),
                width: 2,
              ), // Purple border
            ),
          ),
        ),

        // Style text fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFFBB86FC),
              width: 2,
            ), // Purple border on focus
          ),
          labelStyle: const TextStyle(color: Colors.white70),
        ),

        // Style dialogs
        // <<< FIX WAS HERE: Changed DialogTheme to DialogThemeData
        dialogTheme: DialogThemeData(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFBB86FC), width: 2),
          ),
        ),

        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
