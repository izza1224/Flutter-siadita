import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'splash_screen.dart'; // 1. TAMBAHKAN IMPORT INI

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi SiAdita',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E0821)),
        useMaterial3: true,
      ),
      
      // 2. GANTI INI: Dari LoginScreen() ke SplashScreen()
      home: const SplashScreen(), 
    );
  }
}