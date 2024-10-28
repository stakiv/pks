import 'package:flutter/material.dart';
import 'package:pr8/pages/navigation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Мороженое',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber[50]!),
        useMaterial3: true,
      ),
      home: const MyNavigationPage(),
    );
  }
}
