import 'package:flutter/material.dart';
import 'package:obo_mne/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Про мене',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 55, 255, 188),
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}