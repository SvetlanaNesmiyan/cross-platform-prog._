import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_strategy/url_strategy.dart';

import 'router.dart';
import 'services/github_service.dart';
import 'repositories/github_repository.dart';
import 'view_models/github_stats_view_model.dart';
import 'theme/theme_provider.dart';
import 'services/ad_service.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        Provider(create: (context) => GitHubService(http.Client())),
        Provider(create: (context) => GitHubRepository(Provider.of<GitHubService>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => GitHubStatsViewModel(
            Provider.of<GitHubRepository>(context, listen: false),
          ),
        ),
        Provider(create: (context) => AdService()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Резюме Білдер',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 55, 255, 188),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              fontFamily: 'Roboto',
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 55, 255, 188),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              fontFamily: 'Roboto',
            ),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}