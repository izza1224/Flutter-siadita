import 'package:flutter/material.dart';
import 'home_screen.dart'; // Mengimport HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiAdita App',
      debugShowCheckedModeBanner: false, // Menghilangkan banner "Debug"
      theme: ThemeData(
        // Menentukan tema dasar aplikasi
        primaryColor: const Color(0xFF8B0000), 
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(
          secondary: Colors.redAccent,
        ),
      ),
      home: HomeScreen(), // Mengarahkan ke halaman utama yang akan kita buat
    );
  }
}