import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LudrukDetailPage(),
    );
  }
}

class LudrukDetailPage extends StatelessWidget {
  const LudrukDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna latar belakang cokelat gelap sesuai gambar
    const backgroundColor = Color(0xFF4A1C16);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Utama dengan Border Radius
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'https://via.placeholder.com/400x250', // Ganti dengan URL gambar Anda
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 220,
                    color: Colors.grey[800],
                    child: const Icon(Icons.image, size: 50),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Judul Kategori
              const Text(
                'Karya Budaya',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),

              // Judul Utama
              const Text(
                'Pagelaran Ludruk Kang Bagong',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Tanggal
              const Text(
                '25 April 2025',
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),
              const SizedBox(height: 24),

              // Isi Deskripsi
              const Text(
                'Pertiwi berjalan dengan membawa lentera (dari bangku penonton) '
                'menyusuri jalan mencari sejarahnya yang semakin hilang. Terdengar '
                'sayup-sayup suara tembang kesedihan yang menggambarkarkan sebuah '
                'bangsa yang melupakan sejarahnya. Pertiwi terus berjalan sambil '
                'bercerita (MONOLOG) tentang sebuah generasi yang semakin hari '
                'semakin tercerabut dari akarnya.\n\n'
                'Ditengah perjalanannya pertiwi menemukan sisa-sia sejarah yaitu '
                'patung Dr. Sutomo dan patung Cak Durasim. Kepada kedua patung '
                'tersebut pertiwi (MONOLOG) berkeluh kesah tentang generasi muda '
                'hari ini dan menanyakan bagaimana nasibnya kedepan. Setelah puas '
                'berkeluh kesah pertiwi (OUT) pergi meninggalkan kedua patung tersebut.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
