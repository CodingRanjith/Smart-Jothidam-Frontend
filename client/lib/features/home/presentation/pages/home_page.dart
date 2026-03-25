import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // TODO: Replace with real modules from backend/config
    final modules = [
      'Single Josiyam',
      'Match Making',
      'Career Guidance',
      'Health Insights',
      'Wealth & Finance',
      'Family & Relationships',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Jothidam'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppConstants.profileRoute);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Your Astrology Dashboard',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 4 / 3,
                ),
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index];
                  return _ModuleCard(
                    title: module,
                    onTap: () {
                      // TODO: Navigate to specific module screen when ready
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.primaryContainer.withOpacity(0.9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.auto_awesome,
                color: theme.colorScheme.onPrimaryContainer,
                size: 28,
              ),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

