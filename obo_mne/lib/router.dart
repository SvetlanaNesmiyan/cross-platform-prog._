import 'package:go_router/go_router.dart';
import 'package:obo_mne/pages/home_page.dart';
import 'package:obo_mne/pages/details_page.dart';

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
  ],
);