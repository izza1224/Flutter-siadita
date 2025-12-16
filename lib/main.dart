import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman Login yang akan dimuat pertama

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi SiAdita',
      // Menghilangkan banner DEBUG di pojok kanan atas
      debugShowCheckedModeBanner: false, 
      
      // Mengatur tema dasar aplikasi, menggunakan warna dasar Merah Gelap (5E0821)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E0821)),
        useMaterial3: true,
      ),
      
      // Mengatur LoginScreen sebagai halaman awal yang akan dimuat
      home: const LoginScreen(), 
    );
  }
}