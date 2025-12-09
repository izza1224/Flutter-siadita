import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiAdita App',
      // Menggunakan theme data untuk menetapkan warna background Merah Gelap
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF5E0821), // Background Merah Gelap
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E0821)),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}