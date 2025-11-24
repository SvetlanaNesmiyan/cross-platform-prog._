import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'router.dart';
import 'services/github_service.dart';
import 'repositories/github_repository.dart';
import 'view_models/github_stats_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => GitHubService(http.Client())),
        Provider(create: (context) => GitHubRepository(Provider.of<GitHubService>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => GitHubStatsViewModel(
            Provider.of<GitHubRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Обо мне',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 55, 255, 188),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}