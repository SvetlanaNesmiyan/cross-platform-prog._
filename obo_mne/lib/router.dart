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
);