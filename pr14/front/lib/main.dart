import 'package:flutter/material.dart';
import 'package:front/pages/navigation_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZrY3BsZ212ZGV6a2ZlcnRsdXBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE4NDg1MzcsImV4cCI6MjA0NzQyNDUzN30.OfGrbB2INffjtkmZpvQn35zEruyOhgI0fTiJ2dsSeCE',
    url: 'https://fkcplgmvdezkfertlupq.supabase.co',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
