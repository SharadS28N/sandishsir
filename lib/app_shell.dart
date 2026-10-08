import 'package:flutter/material.dart';

import 'card_screen.dart';
import 'instagram_home_screen.dart';
import 'profile_screen.dart';
import 'spotify_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _section = 0;
  bool _showProfile = false;

  @override
  Widget build(BuildContext context) {
    final body = _showProfile
        ? ProfileScreen(showBottomNavigation: false, onBack: () => setState(() => _showProfile = false))
        : switch (_section) {
            0 => InstagramHomeScreen(onProfile: () => setState(() => _showProfile = true)),
            1 => const SpotifyScreen(showBottomNavigation: false),
            _ => const CardScreen(),
          };
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _section,
        onDestinationSelected: (index) => setState(() {
          _section = index;
          _showProfile = false;
        }),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Instagram'),
          NavigationDestination(icon: Icon(Icons.music_note_outlined), selectedIcon: Icon(Icons.music_note), label: 'Spotify'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined), selectedIcon: Icon(Icons.credit_card), label: 'Card'),
        ],
      ),
    );
  }
}
