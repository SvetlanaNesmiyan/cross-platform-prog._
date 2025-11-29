import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:obo_mne/pages/home_page.dart';
import 'package:obo_mne/pages/details_page.dart';
import 'package:obo_mne/pages/github_stats_page.dart';
import 'package:obo_mne/pages/add_edit_person_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details/:personId',
      builder: (context, state) {
        final personId = int.parse(state.pathParameters['personId']!);
        return DetailsPage(personId: personId);
      },
    ),
    GoRoute(
      path: '/github-stats',
      builder: (context, state) => const GitHubStatsPage(),
    ),
    GoRoute(
      path: '/add-edit',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return AddEditPersonPage(
          person: args?['person'],
          isDuplicate: args?['isDuplicate'] ?? false,
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Сторінку не знайдено',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Помилка 404: ${state.uri}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 55, 255, 188),
              foregroundColor: Colors.white,
            ),
            child: const Text('На головну'),
          ),
        ],
      ),
    ),
  ),
);