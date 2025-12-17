import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: InfoSewaPage());
  }
}

class InfoSewaPage extends StatelessWidget {
  // Contoh data simulasi
  final List<Map<String, dynamic>> items = [
    {
      "title": "Galeri Prabangkara",
      "price": "Rp. 2.500.000",
      "rating": "5.0",
      "image": "assets/images/prabangkara.jpg", // Ganti dengan URL gambar asli
    },
    {
      "title": "Gedung Kesenian Cak Durasim",
      "price": "Rp. 3.500.000",
      "rating": "5.0",
      "image": "assets/images/cak_durasim.jpg",
    },
    {
      "title": "Pendopo Jayengrana",
      "price": "Rp. 2.500.000",
      "rating": "4.0",
      "image": "assets/images/jay.jpg",
    },
    {
      "title": "Wisma Seni",
      "price": "Rp. 1.250.000",
      "rating": "4.5",
      "image": "assets/images/wisma_seni.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF80152B), // Warna maroon background atas
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
              context,
            ); // Fungsi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Info Sewa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Informasi penyewaan gedung kesenian\nCak Durasim",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Bagian List Body
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return buildCard(items[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> data) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              data['image'],
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF80152B),
                          size: 18,
                        ),
                        Text(
                          data['rating'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  data['price'],
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 15),
                // Tombol aksi
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF80152B)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Jadwal Gedung",
                          style: TextStyle(color: Color(0xFF80152B)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF80152B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Lihat Detail",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
