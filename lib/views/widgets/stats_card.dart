import 'package:flutter/material.dart';
import 'package:quiz_app/models/user_progress.dart';

class StatsCard extends StatelessWidget {
  final UserProgress progress;

  const StatsCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Your Stats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.emoji_events,
                  label: 'High Score',
                  value: '${progress.highScore}',
                ),
                _StatItem(
                  icon: Icons.monetization_on,
                  label: 'Total Coins',
                  value: '${progress.totalCoins}',
                ),
                _StatItem(
                  icon: Icons.games,
                  label: 'Games',
                  value: '${progress.gamesPlayed}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
